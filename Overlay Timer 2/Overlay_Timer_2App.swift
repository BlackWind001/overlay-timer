//
//  Overlay_TimerApp.swift
//  Overlay Timer
//
//  Created by Anirudh Kumar on 07/12/25.
//

import SwiftUI

@main
struct Overlay_TimerApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var timerModel = TimerModel(offset: 1*1000)
    @Environment(\.scenePhase) var scenePhase
    
    var times: [String] {
        let totalSeconds = timerModel.offset / 1000
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        return [
            String(format: "%02d", hours),
            String(format: "%02d", minutes),
            String(format: "%02d", seconds)
        ]
    }
    
    var body: some Scene {
        Window("Timer", id: "timer") {
            HStack {
                Text("\(times[0]):\(times[1]):\(times[2])")
            }
            .onAppear() {
                timerModel.startTimer()
            }
        }
    }
}
