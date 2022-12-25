//
//  TimerBootcamp.swift
//  SwiftUI_Thinking
//
//  Created by Quang Bao on 25/12/2022.
//

import SwiftUI

struct TimerBootcamp: View {
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    //MARK: - Current time
//    @State var currentDate = Date()
//    var dateFormatter: DateFormatter {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .medium
//        formatter.timeStyle = .medium
//        return formatter
//    }
    
    //MARK: - Countdown
    @State var count: Int = 10
    @State var finishedText: String? = nil
    
    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [.purple.opacity(0.7), .purple]),
                center: .center,
                startRadius: 5,
                endRadius: 350)
            .edgesIgnoringSafeArea(.all)
            
            Text(finishedText ?? "\(count)")
                .font(.system(size: 50, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .lineLimit(1)
                .minimumScaleFactor(0.1)
        }
        .onReceive(timer) { _ in
            if count < 1 {
                finishedText = "Happy New Year 2023 !!!"
            } else {
                count -= 1
            }
        }
    }
}

struct TimerBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TimerBootcamp()
    }
}
