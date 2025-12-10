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
    @State private var editStates: [Bool] = [false, false, false]
    
    var times: Binding<[String]> {
        return Binding(
            get: {
                let x = calcTimeFromOffset(offset: timerModel.offset)
                return x
            }, set: { _ in }
        )
    }
    
    func resetEditStates () {
        editStates = [false, false, false]
    }
    
    func handleEdit () {
        timerModel.pauseTimer()
        isTimerRunning = false
    }
    
    func handleEditH (isEditing: Bool) {
        handleEdit()
        editStates[0] = isEditing
    }
    
    func handleEditM (isEditing: Bool) {
        handleEdit()
        editStates[1] = isEditing
    }
    
    func handleEditS (isEditing: Bool) {
        handleEdit()
        editStates[2] = isEditing
    }
    
    // When the input is changed, validate the input
    // If not valid, return false.
    // If valid, update the timer offset
    func handleHChange (input: String) -> String {
        var value = Int(input) ?? 0
        value = validateH(value: value) ? value : 0
        timerModel.setOffset(offset: getNewOffsetFromOld_H(newH: value, oldHMS: getHMSFromOffset(offset: timerModel.offset)))
        return String(format: "%02d", getHMSFromOffset(offset: timerModel.offset).H)
    }
    
    func handleMChange (input: String) -> String {
        var value = Int(input) ?? 0
        value = validateM(value: value) ? value : 0
        timerModel.setOffset(offset: getNewOffsetFromOld_M(newM: value, oldHMS: getHMSFromOffset(offset: timerModel.offset)))
        return String(format: "%02d", getHMSFromOffset(offset: timerModel.offset).M)
    }
    
    func handleSChange (input: String) -> String {
        var value = Int(input) ?? 0
        value = validateM(value: value) ? value : 0
        timerModel.setOffset(offset: getNewOffsetFromOld_S(newS: value, oldHMS: getHMSFromOffset(offset: timerModel.offset)))
        return String(format: "%02d", getHMSFromOffset(offset: timerModel.offset).S)
    }
    
    func handleSubmitH (input: String) {
        if let value = Int(input) {
            let newOffset = getNewOffsetFromOld_H(newH: value, oldHMS: getHMSFromOffset(offset: timerModel.offset))
            
            timerModel.setOffset(offset: newOffset)
            resetEditStates()
        }
        else {
            print("Impossible condition reached")
        }
    }
    
    func handleSubmitM (input: String) {
        if let value = Int(input) {
            let newOffset = getNewOffsetFromOld_M(newM: value, oldHMS: getHMSFromOffset(offset: timerModel.offset))
            
            timerModel.setOffset(offset: newOffset)
            resetEditStates()
        }
        else {
            print("Impossible condition reached")
        }
    }
    
    func handleSubmitS (input: String) {
        if let value = Int(input) {
            let newOffset = getNewOffsetFromOld_S(newS: value, oldHMS: getHMSFromOffset(offset: timerModel.offset))
            
            timerModel.setOffset(offset: newOffset)
            resetEditStates()
        }
        else {
            print("Impossible condition reached")
        }
    }
    
    func handleToggle () {
        
        // ToDo: Check error states of the different inputs
        // If any one of them is in error state, do not start timer
        resetEditStates()
        
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
                    onSubmit: handleSubmitH,
                    onEdit: handleEditH,
                    text: times[0],
                    isEditing: $editStates[0]
                )
                Text(":")
                EditableText(
                    onChange: handleMChange,
                    onSubmit: handleSubmitM,
                    onEdit: handleEditM,
                    text: times[1],
                    isEditing: $editStates[1]
                )
                Text(":")
                EditableText(
                    onChange: handleSChange,
                    onSubmit: handleSubmitS,
                    onEdit: handleEditS,
                    text: times[2],
                    isEditing: $editStates[2]
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
