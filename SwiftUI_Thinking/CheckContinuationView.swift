//
//  CheckContinuationView.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 07/06/2023.
//

import SwiftUI

class CheckContinuationNetworkManager {
        
    /// Download images with Async/Await
    func fetchImageWithAsyncAwait(url: URL) async throws -> Data {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        } catch {
            throw URLError(.badURL)
        }
    }
    
    /// Download images with Continuations
    func fetchImageWithContinuations(url: URL) async throws -> Data {
        return await withCheckedContinuation { continuation in
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    continuation.resume(returning: data)
                } else if let error = error {
                    continuation.resume(throwing: error as! Never)
                } else {
                    continuation.resume(throwing: URLError(.badURL) as! Never)
                }
            }
            .resume()
        }
    }
    
    /// Download images from Database
    /// @escaping Closure hard working with api
    func fetchImageFromDatabase(complitionHandle: @escaping (_ image: UIImage) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            complitionHandle(UIImage(systemName: "sun.max.fill")!)
        }
    }
    
    func fetchImageFromDatabase() async -> UIImage {
        return await withCheckedContinuation { continuation in
            fetchImageFromDatabase { image in
                continuation.resume(returning: image)
            }
        }
    }
}

class CheckContinuationViewModel: ObservableObject {
    
    @Published var image: UIImage?
    var networkManager = CheckContinuationNetworkManager()
    let urlString: String = "https://picsum.photos/1000"
    
    func getImages() async {
        
        guard let url = URL(string: urlString) else { return }
        
        do {
            ///Fetching image with AsyncAwait
//            let data = try await networkManager.fetchImageWithAsyncAwait(url: url)
            
            ///Fetching image with Continuations
            let data = try await networkManager.fetchImageWithContinuations(url: url)
            if let image = UIImage(data: data) {
                await MainActor.run {
                    self.image = image
                }
            }
        } catch {
            print(error)
        }
    }
    
    func getSunImagesWithEscapingClosure() {
        networkManager.fetchImageFromDatabase { [weak self] image in
            self?.image = image
        }
    }
    
    func getSunImagesWithAsyncAwait() async {
        self.image = await networkManager.fetchImageFromDatabase()
    }
}

struct CheckContinuationView: View {
    
    @StateObject var vm = CheckContinuationViewModel()
    
    var body: some View {
        VStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            }
        }
        .task {
//            await vm.getImages()
//            vm.getSunImagesWithEscapingClosure()
            await vm.getSunImagesWithAsyncAwait()
        }
    }
}

struct CheckContinuationView_Previews: PreviewProvider {
    static var previews: some View {
        CheckContinuationView()
    }
}
