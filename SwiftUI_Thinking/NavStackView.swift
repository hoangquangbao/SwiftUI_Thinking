//
//  NavStackView.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 08/06/2023.
//

import SwiftUI

struct NavStackView: View {
    var body: some View {
        
        ///NavigationView alway init all of screen before it is to use
        ///That not good for performance of our App
        NavigationView {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 40) {
                        ForEach(1...10, id: \.self) { i in
                            
                            NavigationLink {
                                MySecondScreen(i: i)
                            } label: {
                                Text("Click Me 🤭")
                            }
                        }
                    }
                }
            .navigationTitle("Nav Stack")
        }
    }
}

struct NavStackView_Previews: PreviewProvider {
    static var previews: some View {
        NavStackView()
    }
}

struct MySecondScreen: View {
    
    let i: Int
    init(i: Int) {
        self.i = i
        print("View: \(i)")
    }
    
    var body: some View {
        Text("Screen \(i)")
    }
}
