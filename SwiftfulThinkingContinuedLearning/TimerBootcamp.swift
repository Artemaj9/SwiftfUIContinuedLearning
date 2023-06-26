//
//  TimerBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Artem on 26.06.2023.
//

import SwiftUI
import Combine


struct TimerBootcamp: View {
    
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    
    //Corrent time
    //Current date
    /*
    @State var currentDate: Date = Date()
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
       // formatter.timeStyle = .medium
        formatter.dateStyle = .medium
        return formatter
    }
    */
    
    //Countdown
    /*
    @State var count: Int = 10
    @State var finishedText: String? = nil
    */
    
    //CountdowntoDate
   /*
    @State var timeRemaining: String = ""
    let futureDate: Date = Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date()
    
    func updateTimeRemaining() {
        let remaining = Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: futureDate)
        let hour = remaining.hour ?? 0
        let minute = remaining.minute ?? 0
        let second = remaining.second ?? 0
        timeRemaining = "\(minute) minutes, \(second) seconds"
    }
    */
    
    //Animation counter
    @State var  count: Int = 1
    
    var body: some View {
        ZStack {
            RadialGradient(
                colors: [Color.purple, Color.black],
                center: .center,
                startRadius: 5,
                endRadius: 500)
            .ignoresSafeArea()
            
            TabView(selection: $count) {
                Rectangle()
                    .foregroundColor(.red)
                    .tag(1)
                Rectangle()
                    .foregroundColor(.blue)
                    .tag(2)
                Rectangle()
                    .foregroundColor(.orange)
                    .tag(3)
                Rectangle()
                    .foregroundColor(.pink)
                    .tag(4)
                Rectangle()
                    .foregroundColor(.cyan)
                    .tag(5)
            }
            .tabViewStyle(PageTabViewStyle())
            
            
            HStack(spacing: 15) {
                Circle()
                    .offset(x: 10.0, y: count == 1 ? -200 : 0)
                Circle()
                    .offset(x: 10.0, y: count == 2 ? -200 : 0)
                Circle()
                    .offset(x: 10.0, y: count == 3 ? -200 : 0)
                Circle()
                    .offset(x: 10.0, y: count == 4 ? -200 : 0)
                Circle()
                    .offset(x: 10.0, y: count == 5 ? -200 : 0)
                
            }
            .frame(width: 200)
            .foregroundColor(.white)
            
        }
        .onReceive(timer) { _ in
            withAnimation(.default) {
                count = count == 5 ? 1 : count + 1
            }
        }
            
//            Text(dateFormatter.string(from: currentDate))
//                .font(.system(size: 100, weight: .semibold, design: .rounded))
//                .foregroundColor(.white)
//                .lineLimit(1)
//                .minimumScaleFactor(0.1)
            
            
            
//            Text(timeRemaining)
//                .font(.system(size: 100, weight: .semibold, design: .rounded))
//                                .foregroundColor(.white)
//                                .lineLimit(1)
//                                .minimumScaleFactor(0.1)
//
//        }
//        .onReceive(timer) { _ in
//           updateTimeRemaining()
            
        }
    }
struct TimerBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TimerBootcamp()
    }
}
