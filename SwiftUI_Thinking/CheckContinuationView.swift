//
//  CheckContinuationView.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 07/06/2023.
//

import SwiftUI

class CheckContinuationNetworkManager {
        
    func fetchImage(url: URL) async throws -> Data {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        } catch {
            throw URLError(.badURL)
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
            let data = try await networkManager.fetchImage(url: url)
            if let image = UIImage(data: data) {
                await MainActor.run {
                    self.image = image
                }
            }
        } catch {
            print(error)
        }
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
            await vm.getImages()
        }
    }
}

struct CheckContinuationView_Previews: PreviewProvider {
    static var previews: some View {
        CheckContinuationView()
    }
}
