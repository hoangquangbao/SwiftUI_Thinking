//
//  SwiftUI_ThinkingApp.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 27/11/2022.
//

import SwiftUI

@main
struct SwiftUI_ThinkingApp: App {
    
    static var userdata: UserDataProtocol = UserDataService()

    var body: some Scene {
        WindowGroup {
            ArrayBootcamp(userdata: SwiftUI_ThinkingApp.userdata)
        }
    }
}
