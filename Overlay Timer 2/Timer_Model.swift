//
//  Timer_Model.swift
//  Overlay Timer
//
//  Created by Anirudh Kumar on 07/12/25.
//

import Foundation

class TimerModel: ObservableObject {
    @Published var offset: Int
    var timer: Timer?;
    
    init(offset: Int = 0) {
        self.offset = offset
    }
    
    func setOffset (offset: Int) {
        self.offset = offset
    }
    
    func startTimer () {
        if (offset <= 0) {
            return;
        }
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            
            if self.offset <= 0 {
                self.resetTimer()
                return
            }
            
            DispatchQueue.main.async {
                self.offset -= 1000
            }
        })
    }
    
    func pauseTimer () {
        self.timer?.invalidate()
    }
    
    func resetTimer () {
        self.timer?.invalidate()
        self.timer = nil
        self.offset = 0
    }
}
