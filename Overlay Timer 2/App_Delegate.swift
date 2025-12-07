//
//  App_Delegate.swift
//  Overlay Timer
//
//  Created by Anirudh Kumar on 07/12/25.
//

import Foundation
import Cocoa

final class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        
        // CRITICAL: Delay to let SwiftUI fully initialize the window
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.configureWindow()
        }
    }
    
    private func configureWindow() {
        guard let window = NSApplication.shared.windows.first else {
            print("❌ Warning: No window found")
            return
        }
        
        // Set activation policy first
        NSApp.setActivationPolicy(.accessory)
        
        // Configure window
        window.level = NSWindow.Level(Int(CGWindowLevelForKey(.floatingWindow)))
        
        window.collectionBehavior = [
            .canJoinAllSpaces,
            .fullScreenAuxiliary,
            .canJoinAllApplications
        ]
        
        window.isMovableByWindowBackground = true
        
        // Position on current screen (fixes the negative coordinate issue)
        if let screen = NSScreen.main {
            let screenFrame = screen.visibleFrame
            let windowSize = window.frame.size
            let centeredFrame = NSRect(
                x: screenFrame.midX - windowSize.width / 2,
                y: screenFrame.midY - windowSize.height / 2,
                width: windowSize.width,
                height: windowSize.height
            )
            window.setFrame(centeredFrame, display: true, animate: false)
        }
        
        // Make it key and visible
        window.makeKeyAndOrderFront(nil)
        
        // Force to current space AFTER everything is set up
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            NSApp.activate(ignoringOtherApps: false)
        }
    }
}

