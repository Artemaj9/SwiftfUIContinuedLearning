//
//  HapticsBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Artem on 25.06.2023.
//

import SwiftUI

class HapticManager {
    
    static let instance = HapticManager() //Singleton
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType ) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}

struct HapticsBootcamp: View {
    var body: some View {
        VStack(spacing: 20) {
            Button("#1") { HapticManager.instance.notification(type: .success)}
            Button("#2") { HapticManager.instance.notification(type: .warning)}
            Button("#3") { HapticManager.instance.notification(type: .error)}
            Divider()
            Button("##1") {HapticManager.instance.impact(style: .soft)}
            Button("##2") {HapticManager.instance.impact(style: .light)}
            Button("##3") {HapticManager.instance.impact(style: .medium)}
            Button("##4") {HapticManager.instance.impact(style: .rigid)}
            Button("##5") {HapticManager.instance.impact(style: .heavy)}
        }
        .buttonStyle(.borderedProminent)
    }
}

struct HapticsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        HapticsBootcamp()
    }
}
