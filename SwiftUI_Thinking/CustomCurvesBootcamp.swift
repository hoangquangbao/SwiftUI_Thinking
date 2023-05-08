//
//  CustomCurvesBootcamp.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 08/05/2023.
//

import SwiftUI

struct Curves: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            
            // top left
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            // top right
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            // bottom right
            
            // Draw half circle
            path.addArc(center: CGPoint(x: rect.midX, y: rect.maxY),
                        radius: rect.height / 2,
                        startAngle: Angle(degrees: 0),
                        endAngle: Angle(degrees: 180),
                        clockwise: false)
            
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            // bottom left
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            // comeback top left
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        }
    }
}

struct QuadSample: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.midY))
            path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.midY),
                              control: CGPoint(x: rect.width * 0.25, y: rect.height * 0.25))
            path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.midY),
                              control: CGPoint(x: rect.width * 0.75, y: rect.height * 0.75))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        }
    }
}

struct CustomCurvesBootcamp: View {
    var body: some View {
        QuadSample()
            .fill(LinearGradient(colors: [.blue, .white], startPoint: .leading, endPoint: .trailing))
            .ignoresSafeArea()
        
//        Curves()
//            .frame(width: 100, height: 100)
    }
}

struct CustomCurvesBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CustomCurvesBootcamp()
    }
}
