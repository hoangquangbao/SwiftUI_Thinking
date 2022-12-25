//
//  TimerBootcamp.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 25/12/2022.
//

import SwiftUI

struct TimerBootcamp: View {
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var currentDate = Date()
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
//        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }
    
    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [.purple.opacity(0.7), .purple]),
                center: .center,
                startRadius: 5,
                endRadius: 350)
            .edgesIgnoringSafeArea(.all)
            
            Text(dateFormatter.string(from: currentDate))
                .font(.system(size: 50, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .lineLimit(1)
                .minimumScaleFactor(0.1)
        }
        .onReceive(timer) { value in
            currentDate = value
        }
    }
}

struct TimerBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TimerBootcamp()
    }
}
