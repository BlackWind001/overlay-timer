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
            contentRect: NSRect(x: 100, y: 100, width: 300, height: 200),
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
        // Restore from UserDefaults or use default position
        if !restorePanelFrame(panel) {
            if let screen = NSScreen.main {
                let screenFrame = screen.visibleFrame
                let centeredFrame = NSRect(
                    x: screenFrame.midX - 150,
                    y: screenFrame.midY - 75,
                    width: 300,
                    height: 200
                )
                panel.setFrame(centeredFrame, display: true)
            }
        }
        
        panel.makeKeyAndOrderFront(nil)
        self.panel = panel
        
        
        // Listen for window events
                NotificationCenter.default.addObserver(
                    self,
                    selector: #selector(windowWillClose(_:)),
                    name: NSWindow.willCloseNotification,
                    object: panel
                )
                NotificationCenter.default.addObserver(
                    self,
                    selector: #selector(windowDidMove(_:)),
                    name: NSWindow.didMoveNotification,
                    object: panel
                )
                NotificationCenter.default.addObserver(
                    self,
                    selector: #selector(windowDidResize(_:)),
                    name: NSWindow.didResizeNotification,
                    object: panel
                )
    }
    
    // Window Frame Restoration START
        
        private func restorePanelFrame(_ panel: NSPanel) -> Bool {
            let defaults = UserDefaults.standard
            let x = defaults.double(forKey: "panelOriginX")
            let y = defaults.double(forKey: "panelOriginY")
            let width = defaults.double(forKey: "panelWidth")
            let height = defaults.double(forKey: "panelHeight")
            
            // Only restore if we have valid saved values
            guard width > 100, height > 100 else { return false }
            
            let frame = NSRect(x: x, y: y, width: width, height: height)
            panel.setFrame(frame, display: true)
            return true
        }
        
        private func savePanelFrame(_ window: NSWindow?) {
            guard let window = window else { return }
            let frame = window.frame
            let defaults = UserDefaults.standard
            
            defaults.set(frame.origin.x, forKey: "panelOriginX")
            defaults.set(frame.origin.y, forKey: "panelOriginY")
            defaults.set(frame.size.width, forKey: "panelWidth")
            defaults.set(frame.size.height, forKey: "panelHeight")
        }
        
        @objc func windowWillClose(_ notification: Notification) {
            savePanelFrame(notification.object as? NSWindow)
        }
        
        @objc func windowDidMove(_ notification: Notification) {
            savePanelFrame(notification.object as? NSWindow)
        }
        
        @objc func windowDidResize(_ notification: Notification) {
            savePanelFrame(notification.object as? NSWindow)
        }
    
    // Window Frame Restoration END
}
