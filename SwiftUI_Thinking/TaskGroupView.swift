//
//  TaskGroupView.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 06/06/2023.
//

import SwiftUI

class TaskGroupDataManage {
    
    private func fetchImage(urlString: String) async throws -> UIImage {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                return image
            } else {
                throw URLError(.badURL)
            }
        } catch {
            throw error
        }
    }
    
    func fetchingImageWithAsyncLet() async throws -> [UIImage] {
        
        async let fetchImage1 = fetchImage(urlString: "https://picsum.photos/300")
        async let fetchImage2 = fetchImage(urlString: "https://picsum.photos/300")
        async let fetchImage3 = fetchImage(urlString: "https://picsum.photos/300")
        async let fetchImage4 = fetchImage(urlString: "https://picsum.photos/300")

        let (image1, image2, image3, image4) = await (try fetchImage1, try fetchImage2, try fetchImage3, try fetchImage4)
        
        return Array([image1, image2, image3, image4])
    }
    
    func fetchingImageWithTaskGroup() async throws -> [UIImage] {
        
        let urlStrings: [String] = [
            "https://picsum.photos/30",
            "https://picsum.photos/30",
            "https://picsum.photos/30",
            "https://picsum.photos/30",
            "https://picsum.photos/30",
            "https://picsum.photos/30"
        ]
        
        return try await withThrowingTaskGroup(of: UIImage?.self) { group in
            var images: [UIImage] = []
            images.reserveCapacity(urlStrings.count)
            
            for urlString in urlStrings {
                group.addTask { try? await self.fetchImage(urlString: urlString) }
            }
            
            for try await image in group {
                if image = image {
                    images.append(image)
                }
            }
            
            return images
        }
    }
}

class TaskGroupViewModel: ObservableObject {
    
    @Published var images: [UIImage] = []
    var dataManager = TaskGroupDataManage()
    
    func getImage() async throws {
//        if let images = try? await dataManager.fetchingImageWithAsyncLet() {
//            await MainActor.run {
//                self.images.append(contentsOf: images)
//            }
//        }
        
        if let images = try? await dataManager.fetchingImageWithTaskGroup() {
            await MainActor.run {
                self.images.append(contentsOf: images)
            }
        }
    }
}

struct TaskGroupView: View {
    
    @StateObject var vm = TaskGroupViewModel()
    var columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(vm.images, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                    }
                }
            }
            .navigationTitle("Task Group")
            .task {
                try? await vm.getImage()
            }
        }
    }
}

struct TaskGroupView_Previews: PreviewProvider {
    static var previews: some View {
        TaskGroupView()
    }
}
