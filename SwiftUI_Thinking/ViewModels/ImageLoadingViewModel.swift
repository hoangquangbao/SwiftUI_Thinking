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
    
    let urlString: String
    let imageKey: String
    
    var cancellables = Set<AnyCancellable>()
    let manager = PhotoModelCacheManager.instance
    
    init(url: String, key: String) {
        urlString = url
        imageKey = key
        getImage()
    }
    
    func getImage() {
        if let saveImage = manager.get(key: imageKey) {
            image = saveImage
//            image = UIImage(systemName: "square.and.arrow.up")
            print("Getting saved image.. \(saveImage.description)")
            print("imageKey: " + self.imageKey)
        } else {
            downloadImage()
            print("Downloading image now..")
        }
    }
    
    func downloadImage() {
        guard let url = URL(string: urlString) else {
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
                guard
                    let self = self,
                    let image = image else { return }
                
                self.image = image
                print("image description" + image.description)
                print("imageKey: " + self.imageKey)
                self.manager.add(key: self.imageKey, value: image)
            }
            .store(in: &cancellables)
    }
}
