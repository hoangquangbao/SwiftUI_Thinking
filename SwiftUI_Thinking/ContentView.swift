//
//  ContentView.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 27/11/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State var onOff: Bool = false
    
    var body: some View {
        VStack {
            
            Spacer()
            
            if onOff {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 250, height: 250)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//                    .transition(.move(edge: .leading))
//                    .transition(.scale)
                    .transition(.asymmetric(insertion: .move(edge: .top), removal: .scale))
            }
            
            Button {
                withAnimation(.spring()) {
                    onOff.toggle()
                }
            } label: {
                Text("Click here")
            }

        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
