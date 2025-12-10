//
//  TimerContentView.swift
//  Overlay Timer 2
//
//  Created by Anirudh Kumar on 07/12/25.
//

import SwiftUI

struct TimerContentView: View {
    @StateObject var timerModel = TimerModel(offset: 30000)
    @State private var isTimerRunning: Bool = false
    
    var times: Binding<[String]> {
        return Binding(
            get: {
                let x = calcTimeFromOffset(offset: timerModel.offset)
                return x
            }, set: { _ in }
        )
    }
    
    func handleEdit (isEditing: Bool) {
        timerModel.pauseTimer()
        isTimerRunning = false
    }
    
    // When the input is changed, validate the input
    // If not valid, return false.
    // If valid, update the timer offset
    func handleHChange (input: String) -> Bool {
        if let value = Int(input) {
            if validateH(value: value) {
                return true
            }
            
            timerModel.setOffset(offset: getNewOffsetFromOld_H(newH: value, oldHMS: getHMSFromOffset(offset: timerModel.offset)))
        }
        
        return false
    }
    
    func handleMChange (input: String) -> Bool {
        if let value = Int(input) {
            if validateM(value: value) {
                return true
            }
            
            timerModel.setOffset(offset: getNewOffsetFromOld_M(newM: value, oldHMS: getHMSFromOffset(offset: timerModel.offset)))
        }
        
        return false
    }
    
    func handleSChange (input: String) -> Bool {
        if let value = Int(input) {
            if validateS(value: value) {
                return true
            }
            
            timerModel.setOffset(offset: getNewOffsetFromOld_S(newS: value, oldHMS: getHMSFromOffset(offset: timerModel.offset)))
        }
        
        return false
    }
    
    func handleSubmitH (input: String) {
        if let value = Int(input) {
            let newOffset = getNewOffsetFromOld_H(newH: value, oldHMS: getHMSFromOffset(offset: timerModel.offset))
            
            timerModel.setOffset(offset: newOffset)
        }
        else {
            print("Impossible condition reached")
        }
    }
    
    func handleSubmitM (input: String) {
        if let value = Int(input) {
            let newOffset = getNewOffsetFromOld_M(newM: value, oldHMS: getHMSFromOffset(offset: timerModel.offset))
            
            timerModel.setOffset(offset: newOffset)
        }
        else {
            print("Impossible condition reached")
        }
    }
    
    func handleSubmitS (input: String) {
        if let value = Int(input) {
            let newOffset = getNewOffsetFromOld_S(newS: value, oldHMS: getHMSFromOffset(offset: timerModel.offset))
            
            timerModel.setOffset(offset: newOffset)
        }
        else {
            print("Impossible condition reached")
        }
    }
    
    func handleToggle () {
        if isTimerRunning {
            timerModel.pauseTimer()
        }
        else {
            timerModel.startTimer()
        }
        
        isTimerRunning.toggle()
    }
    
    var body: some View {
        VStack {
            HStack {
                EditableText(
                    onChange: handleHChange,
                    onSubmit: handleSubmitH, onEdit: handleEdit, text: times[0]
                )
                Text(":")
                EditableText(
                    onChange: handleMChange,
                    onSubmit: handleSubmitM, onEdit: handleEdit, text: times[1]
                )
                Text(":")
                EditableText(
                    onChange: handleSChange,
                    onSubmit: handleSubmitS, onEdit: handleEdit, text: times[2]
                )
            }
            .frame(minWidth: 300, minHeight: 100)
            .font(.system(size: 48, weight: .bold))
            .onChange(of: timerModel.offset) { _ in
                
            }
            Button(action: {
                handleToggle()
            }, label: {
                Image(systemName: isTimerRunning ? "pause.fill" : "play.fill")
                    .font(.system(size: 32))
                    .foregroundColor(.white)
            })
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
