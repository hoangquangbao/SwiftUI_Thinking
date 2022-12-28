//
//  ImageLoadingViewModel.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 27/12/2022.
//

import Foundation
import SwiftUI
import Combine

class ImageLoadingViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = true
    var url: String = ""
    
    var cancellables = Set<AnyCancellable>()
    
    init(url: String) {
        self.url = url
        downloadImage()
    }
    
    func downloadImage() {
        print("Downloading image now..")
        guard let url = URL(string: url) else {
            isLoading = false
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
//            .map { (data, response) -> UIImage? in
//                return UIImage(data: data)
//            }
            .receive(on: DispatchQueue.main)
            .map { UIImage(data: $0.data) }
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] image in
                self?.image = image
            }
            .store(in: &cancellables)
    }
}
