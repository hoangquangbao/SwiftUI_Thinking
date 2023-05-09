//
//  AnimateableData.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 09/05/2023.
//

import SwiftUI

struct RoundRectangleCorner: Shape {
    
    var cornerRadius: CGFloat
    
    /// In the Shape you need this property to activate animation for it
    var animatableData: CGFloat {
        get { cornerRadius }
        set { cornerRadius = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            /// Step 1
            path.move(to: CGPoint(x: rect.minX, y: rect.minY + cornerRadius))
//            path.addQuadCurve(to: CGPoint(x: rect.minX + size, y: rect.minY),
//                              control: CGPoint(x: rect.minX, y: rect.minY))
//            path.addLine(to: CGPoint(x: rect.minX + size, y: rect.minY))
            path.addArc(center: CGPoint(x: rect.minX + cornerRadius, y: rect.minY + cornerRadius),
                        radius: cornerRadius,
                        startAngle: Angle(degrees: 0),
                        endAngle: Angle(degrees: 360),
                        clockwise: false)
            path.addLine(to: CGPoint(x: rect.minX + cornerRadius, y: rect.minY))
            
            /// Step 2
            path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY))
            path.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY + cornerRadius),
                        radius: cornerRadius,
                        startAngle: Angle(degrees: 0),
                        endAngle: Angle(degrees: 360),
                        clockwise: false)
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + cornerRadius))
            
            /// Step 3
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadius))
            path.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY -  cornerRadius),
                        radius: cornerRadius,
                        startAngle: Angle(degrees: 0),
                        endAngle: Angle(degrees: 360),
                        clockwise: false)
            path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY))

            /// Step 4
            path.addLine(to: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY))
            path.addArc(center: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY - cornerRadius),
                        radius: cornerRadius,
                        startAngle: Angle(degrees: 0),
                        endAngle: Angle(degrees: 360),
                        clockwise: false)
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - cornerRadius))
        }
    }
}

struct AnimateableData: View {
    
    @State private var animation: Bool = false
    
    var body: some View {
//        RoundedRectangle(cornerRadius: animation ? 60 : 10)
//            .frame(width: 300, height: 300)
        ZStack {
            RoundRectangleCorner(cornerRadius: animation ? 60 : 10)
                .frame(width: 300, height: 300)
        }
        .onAppear {
            withAnimation(Animation.linear(duration: 2).repeatForever()) {
                animation.toggle()
            }
        }
    }
}

struct AnimateableData_Previews: PreviewProvider {
    static var previews: some View {
        AnimateableData()
    }
}
