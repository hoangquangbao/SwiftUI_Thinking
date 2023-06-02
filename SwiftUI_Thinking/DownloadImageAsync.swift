//
//  DownloadImageAsync.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 01/06/2023.
//

import SwiftUI

class DownloadImageAsyncDataManager {
    
    let url = URL(string: "https://picsum.photos/200/300")!
    
    func downloadImage(completionHandle: @escaping (_ image: UIImage?, _ error: Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, responsitory, error in
            guard let data = data,
                  let image = UIImage(data: data),
                  let responsitory = responsitory as? HTTPURLResponse,
                  responsitory.statusCode >= 200 && responsitory.statusCode < 300,
                  error == nil else {
                      completionHandle(nil, error)
                      return
                  }
            completionHandle(image, nil)
        }
        .resume()
    }
}

class DownloadImageAsyncViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var error: Error? = nil
    var dataManager = DownloadImageAsyncDataManager()
    
    init() {
        getData()
    }
    
    private func getData() {
        dataManager.downloadImage { [weak self] image, error in
            DispatchQueue.main.async {
                if let image = image {
                    self?.image = image
                } else {
                    self?.error = error
                }
            }
        }
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
