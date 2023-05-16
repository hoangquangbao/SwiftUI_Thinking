//
//  UnitTestingBootcampViewModel.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 15/05/2023.
//

import Foundation
import SwiftUI

class UnitTestingBootcampViewModel: ObservableObject {
    
    @Published var isPremium: Bool
    @Published var dataArray: [String] = []
    @Published var selectedItem: String? = nil

    init(isPremium: Bool) {
        self.isPremium = isPremium
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
}
