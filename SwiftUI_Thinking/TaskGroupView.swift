//
//  TaskGroupView.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 06/06/2023.
//

import SwiftUI

class TaskGroupDataManage {
    
    func fetchImage(urlString: String?) async throws -> UIImage {
        
        guard let urlString = urlString,
              let url = URL(string: urlString) else {
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
}

class TaskGroupViewModel: ObservableObject {
    
    @Published var images: [UIImage] = []
    
    let url = "https://picsum.photos/300"
    
    var dataManager = TaskGroupDataManage()
    
    init() {
        Task {
            do {
                let image = try await dataManager.fetchImage(urlString: url)
                await MainActor.run {
                    self.images.append(image)
                }
            } catch {
                
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
        }
    }
}

struct TaskGroupView_Previews: PreviewProvider {
    static var previews: some View {
        TaskGroupView()
    }
}
