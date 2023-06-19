//
//  ContentView.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 27/11/2022.
//

import SwiftUI

//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundColor(.accentColor)
//            Text("Hello, world!")
//        }
//        .padding()
//    }
//}

struct ContentView: View {
    @State private var isMenuVisible = false
    
    var body: some View {
        VStack {
            Menu("Options") {
                Button("Option 1") {
                }
                Button("Option 2") {
                }
            }
            .modifier(
                MenuWidthModifier(width: 50)
            )
        }
    }
}

struct MenuWidthModifier: ViewModifier {
    let width: CGFloat
    
    func body(content: Content) -> some View {
        content
            .frame(width: width)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

