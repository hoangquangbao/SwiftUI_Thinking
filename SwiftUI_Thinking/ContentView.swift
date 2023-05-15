//
//  ContentView.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 27/11/2022.
//

import SwiftUI

struct RotateViewModifier: ViewModifier {
    
    var degrees: Double
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(Angle(degrees: degrees))
//            .offset(x: degrees != 0 ? 0 : 150,
//                    y: degrees != 0 ? 0 : 100)
            .offset(x: degrees != 0 ? UIScreen.main.bounds.width : 0,
                    y: degrees != 0 ? UIScreen.main.bounds.height : 0)
    }
}

extension AnyTransition {
    static var rotating: AnyTransition {
        modifier(active: RotateViewModifier(degrees: 180),
                                      identity: RotateViewModifier(degrees: 0))
    }
    
    static func rotating(rotation: Double) -> AnyTransition {
        modifier(active: RotateViewModifier(degrees: rotation),
                                      identity: RotateViewModifier(degrees: 0))
    }
    
    static func rotateOn() -> AnyTransition {
//        return AnyTransition.asymmetric(insertion: .move(edge: .bottom),
//                                        removal: .scale)
        asymmetric(insertion: .rotating,
                                        removal: .move(edge: .bottom))
    }
}

struct ContentView: View {
    
    @State var onOff: Bool = false
    
    var body: some View {
        ZStack(content: {
            Image("img_bg")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea(.all)
                .blur(radius: 5)
            
            VStack {
                Button {
                    withAnimation(.easeInOut(duration: 2.0)) {
                        onOff.toggle()
                    }
                } label: {
                    Text("Assignment")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                
                if onOff {
//                    ZStack {
//                        ForEach(0..<5) { i in
//                            Image("img_la_bai")
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .cornerRadius(10.0)
//                                .frame(width: 200, height: 400)
//                                .transition(.rotating(rotation: 200))
//                                .rotationEffect(Angle(degrees: Double(i * 5)), anchor: .bottomLeading)
//                        }
//                    }
                    
                    Image("img_la_bai")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10.0)
                        .frame(width: 200, height: 400)
//                        .transition(.rotating(rotation: 200))
                        .transition(.rotateOn())
                }
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
