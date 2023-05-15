//
//  UnitTestingBootcampView.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 15/05/2023.
//
/*
 1. Unit Tests
 - Test the business the logic in your app
 - this link to tutorial for unit testing:
 https://www.youtube.com/watch?v=eqdvIUKsM2A&list=PLwvDm4Vfkdphc1LLLjCaEd87BEg07M97y&index=18&ab_channel=SwiftfulThinking
 
 2. UI Test
 - test the UN of your app
 
 */

import SwiftUI

struct UnitTestingBootcampView: View {
    
    @StateObject var vm: UnitTestingBootcampViewModel
    
    init(isPremium: Bool) {
        _vm = StateObject(wrappedValue: UnitTestingBootcampViewModel(isPremium: isPremium))
    }
    
    var body: some View {
        Text(vm.isPremium.description)
    }
}

struct UnitTestingBootcampView_Previews: PreviewProvider {
        
    static var previews: some View {
        UnitTestingBootcampView(isPremium: false)
    }
}
