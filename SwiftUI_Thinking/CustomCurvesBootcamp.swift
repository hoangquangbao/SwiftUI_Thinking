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

struct CustomCurvesBootcamp: View {
    var body: some View {
        Curves()
            .frame(width: 200, height: 200)
    }
}

struct CustomCurvesBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CustomCurvesBootcamp()
    }
}
