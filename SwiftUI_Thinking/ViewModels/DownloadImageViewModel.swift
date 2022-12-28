//
//  DownloadImageViewModel.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 26/12/2022.
//

import Foundation
import Combine

class DownloadImageViewModel: ObservableObject {

    @Published var dataArray: [PhotoModel] = []
    var cancellables = Set<AnyCancellable>()
    let dataService = PhotoModelDataService.instance
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$photoModels
            .sink { [weak self] returnPhotoModels in
                self?.dataArray = returnPhotoModels
            }
            .store(in: &cancellables)
    }
}
