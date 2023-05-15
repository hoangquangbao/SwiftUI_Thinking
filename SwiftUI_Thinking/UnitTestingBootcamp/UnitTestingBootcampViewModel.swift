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

    init(isPremium: Bool) {
        self.isPremium = isPremium
    }
}
