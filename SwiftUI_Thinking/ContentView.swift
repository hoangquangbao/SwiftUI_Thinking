//
//  ContentView.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 27/11/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.green.ignoresSafeArea()
            
            ViewThatFits {
                Text("This is a view that fits. It's height is 400.")
                Text("This is a view that fits.")
            }
        }
        .frame(height: 400)
        .padding(20)
//        .padding(50)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
