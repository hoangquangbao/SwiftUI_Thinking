//
//  AsynLetView.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 06/06/2023.
//

import SwiftUI

struct AsynLetView: View {
    
    var columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    @State var images: [UIImage] = []
    let url = URL(string: "https://picsum.photos/300")!
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(images, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                    }
                }
            }
            .navigationTitle("Async Let")
            .onAppear {
                ///Chú ý:
                ///Tất cả các fetchImage nằm chung một Task thì
                ///- nó sẽ show ra image lâu hơn vì nó chờ cho tất cả fetchImage hoàn tất đã
                ///- Để giải quyết nó thì ta có thể:
                ///- CÁCH 1: Chia mỗi fetchImage cho mỗi Task
                Task {
                    do {
                        let image1 = try await fetchImage()
                        let image2 = try await fetchImage()
                        let image3 = try await fetchImage()
                        let image4 = try await fetchImage()

                        self.images.append(image1)
                        self.images.append(image2)
                        self.images.append(image3)
                        self.images.append(image4)
                    } catch {
                        
                    }
                }
                ///CÁCH 2: ...
            }
        }
    }
    
    func fetchImage() async throws -> UIImage {
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

struct AsynLetView_Previews: PreviewProvider {
    static var previews: some View {
        AsynLetView()
    }
}
