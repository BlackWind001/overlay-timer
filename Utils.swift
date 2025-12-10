//
//  Utils.swift
//  Overlay Timer 2
//
//  Created by Anirudh Kumar on 09/12/25.
//

import Foundation

struct HMS {
    var H: Int
    var M: Int
    var S: Int
}

func validateS (value: Int) -> Bool {
    if (value >= 0 && value <= 59) {
        return true
    }
    return false
}

func validateM (value: Int) -> Bool {
    if (value >= 0 && value <= 59) {
        return true
    }
    return false
}

func validateH (value: Int) -> Bool {
    if (value >= 0 && value <= 23) {
        return true
    }
    
    return false
}

func calcTimeFromOffset (offset: Int) -> [String] {
    let totalSeconds = offset / 1000
    let hours = totalSeconds / 3600
    let minutes = (totalSeconds % 3600) / 60
    let seconds = totalSeconds % 60
    
    return [
        String(format: "%02d", hours),
        String(format: "%02d", minutes),
        String(format: "%02d", seconds)
    ]
}

func getHMSFromOffset (offset: Int) -> HMS {
    let totalSeconds = offset / 1000
    let hours = totalSeconds / 3600
    let minutes = (totalSeconds % 3600) / 60
    let seconds = totalSeconds % 60
    return HMS(H: hours, M: minutes, S: seconds)
}

func getNewOffsetFromOld_H (newH: Int, oldHMS: HMS) -> Int {
    return ((newH * 3600) + oldHMS.M * 60 + oldHMS.S) * 1000
}

func getNewOffsetFromOld_M (newM: Int, oldHMS: HMS) -> Int {
    return ((newM * 60) + oldHMS.H * 3600 + oldHMS.S) * 1000
}

func getNewOffsetFromOld_S (newS: Int, oldHMS: HMS) -> Int {
    return ((newS) + oldHMS.H * 3600 + oldHMS.M * 60) * 1000
}
