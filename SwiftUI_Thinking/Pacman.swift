//
//  Pacman.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 09/05/2023.
//

import SwiftUI

struct PacmanShape: Shape {
    
    var cornerRadius: Double
    
    var animatableData: Double {
        get { cornerRadius }
        set { cornerRadius = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.midY))
            path.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                        radius: rect.height / 2,
                        startAngle: Angle(degrees: cornerRadius),
                        endAngle: Angle(degrees: 360 - cornerRadius),
                        clockwise: false)
        }
    }
}

struct Pacman: View {
    
    @State private var animation: Bool = false
    
    var body: some View {
        PacmanShape(cornerRadius: animation ? 20 : 0)
            .frame(width: 100, height: 100)
            .onAppear {
                withAnimation(.easeInOut(duration: 1).repeatForever()) {
                    animation.toggle()
                }
            }
    }
}

struct Pacman_Previews: PreviewProvider {
    static var previews: some View {
        Pacman()
    }
}
