//
//  UnitTestingBootcampViewModel.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 15/05/2023.
//

import Foundation
import SwiftUI
import Combine

protocol NewDataServiceProtocol {
    func downloadItemWithEscaping(completion: @escaping (_ items: [String]) -> ())
    func downloadItemWithCombine() -> AnyPublisher<[String], Error>
}

class NewMockDataService: NewDataServiceProtocol {
    
    let items: [String]
    
    init(items: [String]?) {
        self.items = items ?? ["Element_1", "Element_2", "Element_3"]
    }
    
    func downloadItemWithEscaping(completion: @escaping (_ items: [String]) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            completion(self.items)
        }
    }
    
    func downloadItemWithEscaping2(completion: @escaping ([String]) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            completion(self.items)
        }
    }
    
    func downloadItemWithCombine() -> AnyPublisher<[String], Error> {
        Just(items)
            .tryMap { publisherItems in
                guard !publisherItems.isEmpty else {
                    throw URLError(.badServerResponse)
                }
                return publisherItems
            }
            .eraseToAnyPublisher()
    }
    
    func downloadItemWithCombine2() -> AnyPublisher<[String], Error> {
        Just(items)
            .tryMap { publisherItems in
                guard !publisherItems.isEmpty else {
                    throw URLError(.badServerResponse)
                }
                return publisherItems
            }
            .eraseToAnyPublisher()
    }
}

class UnitTestingBootcampViewModel: ObservableObject {
    
    @Published var isPremium: Bool
    @Published var dataArray: [String] = []
    @Published var selectedItem: String? = nil
    
    let dataService: NewMockDataService
    var cancellable = Set<AnyCancellable>()

    init(isPremium: Bool, dataService: NewMockDataService = NewMockDataService(items: nil)) {
        self.isPremium = isPremium
        self.dataService = dataService
    }
    
    func addItem(item: String) {
        guard !item.isEmpty else { return }
        dataArray.append(item)
    }
    
    func selectedItem(item: String) {
        if let x = dataArray.first(where: { $0 == item }) {
            selectedItem = x
        } else {
            selectedItem = nil
        }
    }
    
    func saveItem(item: String) throws {
        guard !item.isEmpty else {
            throw DataError.noData
        }
        
        if let x = dataArray.first(where: { $0 == item }) {
            print("Save item \(x) here!!!")
        } else {
            throw DataError.itemNotFound
        }
    }
    
    enum DataError: LocalizedError {
        case noData
        case itemNotFound
    }
    
    func downloadWithEscaping() {
        dataService.downloadItemWithEscaping { [weak self] items in
            self?.dataArray = items
        }
    }
    
    func downloadWithEscaping2() {
        dataService.downloadItemWithEscaping2 { items in
            self.dataArray = items
        }
    }
    
    func downloadWithCombine() {
        dataService.downloadItemWithCombine()
            .sink { _ in
                
            } receiveValue: { [weak self] items in
                self?.dataArray = items
            }
            .store(in: &cancellable)
    }
}
