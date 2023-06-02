//
//  DownloadImageAsync.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 01/06/2023.
//

import SwiftUI
import Combine

class DownloadImageAsyncDataManager {
    
    let url = URL(string: "https://picsum.photos/200/300")!
    
    func handleResponse(data: Data?, response: URLResponse?) -> UIImage? {
        guard let data = data,
              let image = UIImage(data: data),
              let response = response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
                  return nil
              }
        return image
    }
    
    func downloadImageWithEscapingClosure(completionHandle: @escaping (_ image: UIImage?, _ error: Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            let image = self.handleResponse(data: data, response: response)
            completionHandle(image, error)
        }
        .resume()
    }
    
    func downloadImageWithCombine() -> AnyPublisher<UIImage?, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(handleResponse)
            .mapError({ $0 })
            .eraseToAnyPublisher()
    }
}

class DownloadImageAsyncViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var error: Error? = nil
    
    var dataManager = DownloadImageAsyncDataManager()
    var cancellable = Set<AnyCancellable>()
    
    init() {
//        getDataWithEscapingClosure()
        getDataWithCombine()
    }
    
    private func getDataWithEscapingClosure() {
        dataManager.downloadImageWithEscapingClosure { [weak self] image, error in
            DispatchQueue.main.async {
                if let image = image {
                    self?.image = image
                }
            }
        }
    }
    
    private func getDataWithCombine() {
        dataManager.downloadImageWithCombine()
            .sink { _ in

            } receiveValue: { [weak self] image in
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
            .store(in: &cancellable)
    }
}

struct DownloadImageAsync: View {
    
    @StateObject var vm = DownloadImageAsyncViewModel()
    
    var body: some View {
        VStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.gray, lineWidth: 5)
                    )
                    .padding(.horizontal)
            } else if let error = vm.error {
                Text("Error: " + error.localizedDescription)
            }
        }
    }
}

struct DownloadImageAsync_Previews: PreviewProvider {
    static var previews: some View {
        DownloadImageAsync()
    }
}
