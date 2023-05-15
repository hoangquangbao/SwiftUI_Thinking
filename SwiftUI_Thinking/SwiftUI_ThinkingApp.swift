//
//  SwiftUI_ThinkingApp.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 27/11/2022.
//

import SwiftUI

@main
struct SwiftUI_ThinkingApp: App {
    
    static var isPremium: Bool = false
    
    var body: some Scene {
        WindowGroup {
            UnitTestingBootcampView(isPremium: SwiftUI_ThinkingApp.isPremium)
        }
    }
}
