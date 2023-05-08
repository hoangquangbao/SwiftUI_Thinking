//
//  CustomShapesBootcamp.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 08/05/2023.
//

import SwiftUI

struct Dinamond: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            
            /// Using this code
//            path.addLine(to: CGPoint(x: (rect.maxX * 0.75), y: rect.minY))
//            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY * 0.25))
//            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
//            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY * 0.25))
//            path.addLine(to: CGPoint(x: (rect.maxX * 0.25), y: rect.minY))
            
            /// Or this code
            path.addLines([CGPoint(x: (rect.maxX * 0.75), y: rect.minY),
                           CGPoint(x: rect.maxX, y: rect.maxY * 0.25),
                           CGPoint(x: rect.midX, y: rect.maxY),
                           CGPoint(x: rect.minX, y: rect.maxY * 0.25),
                           CGPoint(x: (rect.maxX * 0.25), y: rect.minY)
                          ])
        }
    }
}

struct CustomShapesBootcamp: View {
    var body: some View {
        ZStack(alignment: .center) {
            Dinamond()
                .frame(width: 300, height: 300)
        }
    }
}

struct CustomShapesBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CustomShapesBootcamp()
    }
}
