# Concurrency

This repository had funcs to download images from internet as "Download with @escaping_Closure, Combine and Async"

### **1. @escaping closure**
### **2. Combine**
### **3. Async**
- Use async keyword to mark it is async function.
- Use MainActor to changes from background threads to main thread.
### **4. Async_Let**
- This help download image with the same time.
- But you need repeat code download for each download.

<details>
<summary>Full Code</summary>

```
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
    
    func downloadImageWithAsync() async throws -> UIImage? {
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            return handleResponse(data: data, response: response)
        } catch {
            throw error
        }
    }
}

class DownloadImageAsyncViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var error: Error? = nil
    
    var dataManager = DownloadImageAsyncDataManager()
    var cancellable = Set<AnyCancellable>()
    
    init() {
//        getDataWithEscapingClosure()
//        getDataWithCombine()
        Task {
            await getDataWithAsync()
        }
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
            .receive(on: DispatchQueue.main)
            .sink { _ in

            } receiveValue: { [weak self] image in
//                DispatchQueue.main.async {
//                    self?.image = image
//                }
                /// If we add receive to confirm schedule DispatchQueue.main then
                self?.image = image
            }
            .store(in: &cancellable)
    }
    
    private func getDataWithAsync() async {
        /// With Errors thrown from here are not handled we can:
        /// 1. Use do-catch to handle
//        do {
//            let image = try await dataManager.downloadImageWithAsync()
//            DispatchQueue.main.async {
//                self.image = image
//            }
//        } catch {
//
//        }
        /// Or try? to handle
        let image = try? await dataManager.downloadImageWithAsync()
        /// With await we don't use DispatchQueue.main to changes from background threads to main threads because (28:12 seconds). You should use MainActor.run
        await MainActor.run {
            self.image = image
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

  
```
</details>
