//
//  TimerContentView.swift
//  Overlay Timer 2
//
//  Created by Anirudh Kumar on 07/12/25.
//

import SwiftUI

struct TimerContentView: View {
    @StateObject var timerModel = TimerModel(offset: 30000)
    
    var times: Binding<[String]> {
        let totalSeconds = timerModel.offset / 1000
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        return Binding(
            get: {
                [
                    String(format: "%02d", hours),
                    String(format: "%02d", minutes),
                    String(format: "%02d", seconds)
                ]
            }, set: {newValue in
                
            }
        )
    }
    
    func handleEdit (isEditing: Bool) {
        
    }
    
    func validateHours (input: String) -> Bool {
        if (!input.isEmpty) {
            if let value = Int(input) {
                if (value >= 0 && value <= 23) {
                    return true
                }
            }
        }
        
        return false
    }
    
    func submitHours (input: String) -> Void {
        if let value = Int(input) {
            let totalSeconds = timerModel.offset / 1000
            let newOffset = (value * 3600) + ((totalSeconds % 3600))
            
            timerModel.setOffset(offset: newOffset)
        }
        else {
            print("Impossible condition reached")
        }
    }
    
    func validateMinutes (input: String) -> Bool {
        if (!input.isEmpty) {
            if let value = Int(input) {
                if (value >= 0 && value <= 59) {
                    return true
                }
            }
        }
        return false
    }
    
    func validateSeconds (input: String) -> Bool {
        if (!input.isEmpty) {
            if let value = Int(input) {
                if (value >= 0 && value <= 59) {
                    return true
                }
            }
        }
        return false
    }
    
    var body: some View {
        HStack {
            EditableText(onValidate: validateHours, text: times[0])
            Text(":")
            EditableText(onValidate: validateMinutes, text: times[1])
            Text(":")
            EditableText(onValidate: validateSeconds, text: times[2])
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .font(.system(size: 48, weight: .bold))
        .onAppear {
            timerModel.startTimer()
        }
    }
}
