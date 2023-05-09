//
//  CarView.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 09/05/2023.
//

import SwiftUI

struct BackgroundClockPath: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.midY))
            path.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                        radius: rect.width - 100,
                        startAngle: Angle(degrees: 0),
                        endAngle: Angle(degrees: 360),
                        clockwise: true)
        }
    }
}

struct ClockPath: Shape {

    var value: Double = 10

    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX - value, y: rect.midY))
            path.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                        radius: value,
                        startAngle: Angle(degrees: 0),
                        endAngle: Angle(degrees: 360),
                        clockwise: false)
            path.addLine(to: CGPoint(x: rect.midX + value, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        }
    }
}

struct ClockView: View {
    
    @State var active: Bool = false
    
    var body: some View {
        ZStack() {
            BackgroundClockPath()
                .fill(LinearGradient(colors: [.red.opacity(0.5), .blue.opacity(0.5)],
                                     startPoint: .topLeading,
                                     endPoint: .bottomTrailing))
                .frame(width: 250,
                       height: 250)
            
            ClockPath()
                .fill(LinearGradient(colors: [.black],
                                     startPoint: .top,
                                     endPoint: .bottom))
                .frame(width: 100, height: 200)
                .rotationEffect(.degrees(active ? 360 : 0))
                .animation(Animation.linear(duration: 3.5).repeatForever(autoreverses: false), value: active)

            ClockPath()
                .fill(LinearGradient(colors: [.yellow],
                                     startPoint: .top,
                                     endPoint: .bottom))
                .frame(width: 100, height: 250)
                .rotationEffect(.degrees(active ? 360 : 0))
                .animation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false), value: active)
        }
        .onAppear {
            self.active = true
        }
    }
}

struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        ClockView()
    }
}
