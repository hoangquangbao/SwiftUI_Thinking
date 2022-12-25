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
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
//        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }
    
    //MARK: - Countdown
//    @State var count: Int = 10
//    @State var finishedText: String? = nil
    
    //MARK: - Countdown to future date
    @State var timeRemaining: String = ""
    @State var futureDate: Date = (Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date())
    
    func updateTimeRemaining() {
        let remaining = Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: futureDate)
        let hour = remaining.hour ?? 0
        let minute = remaining.minute ?? 0
        let second = remaining.second ?? 0
        timeRemaining = "\(hour):\(minute):\(second)"
    }
    
    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [.purple.opacity(0.7), .purple]),
                center: .center,
                startRadius: 5,
                endRadius: 350)
            .edgesIgnoringSafeArea(.all)
            
            Text(timeRemaining)
                .font(.system(size: 50, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .lineLimit(1)
                .minimumScaleFactor(0.1)
        }
        .onReceive(timer) { _ in
            updateTimeRemaining()
        }
    }
}

struct TimerBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TimerBootcamp()
    }
}
