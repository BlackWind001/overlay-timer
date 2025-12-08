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
    
    var body: some Scene {
        Settings {}  // Empty - all windows created in AppDelegate
    }
}
