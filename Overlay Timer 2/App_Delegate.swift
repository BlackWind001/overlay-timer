//
//  App_Delegate.swift
//  Overlay Timer
//
//  Created by Anirudh Kumar on 07/12/25.
//

import Foundation
import Cocoa
import SwiftUI

final class AppDelegate: NSObject, NSApplicationDelegate {
    private var panel: NSPanel?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.accessory)
        
        // Create NSPanel from scratch
        let panel = NSPanel(
            contentRect: NSRect(x: 100, y: 100, width: 300, height: 150),
            styleMask: [
                .titled,
                .closable,
                .nonactivatingPanel,
                .resizable
            ],
            backing: .buffered,
            defer: false
        )
        
        // Embed SwiftUI content
        let hostingController = NSHostingController(rootView: TimerContentView())
        panel.contentViewController = hostingController
        
        // Configure for floating + draggable
        panel.level = NSWindow.Level(Int(CGWindowLevelForKey(.floatingWindow)))
        panel.collectionBehavior = [
            .canJoinAllSpaces,
            .fullScreenAuxiliary,
            .canJoinAllApplications
        ]
        panel.isMovableByWindowBackground = true  // ← WORKS with NSPanel
        panel.backgroundColor = NSColor.windowBackgroundColor
        panel.isOpaque = false
        
        // Position on main screen
        if let screen = NSScreen.main {
            let screenFrame = screen.visibleFrame
            let centeredFrame = NSRect(
                x: screenFrame.midX - 150,
                y: screenFrame.midY - 75,
                width: 300,
                height: 150
            )
            panel.setFrame(centeredFrame, display: true)
        }
        
        panel.makeKeyAndOrderFront(nil)
        self.panel = panel
    }
}
