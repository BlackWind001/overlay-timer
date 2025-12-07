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
        guard let window = NSApplication.shared.windows.first else {
                    print("Warning: No window found")
                    return
                }
        
        window.level = .floating
        window.collectionBehavior = [
                    .canJoinAllSpaces,           // Visible on all spaces
                    .fullScreenAuxiliary,         // Show on fullscreen apps (Lion+)
                    .canJoinAllApplications,      // Appear on top of other apps
//                    .moveToActiveSpace
                ]
        NSWorkspace.shared.notificationCenter.addObserver(
            forName: NSWorkspace.activeSpaceDidChangeNotification,
            object: NSWorkspace.shared,
            queue: .main
        ) { _ in
            if let window = NSApplication.shared.windows.first {
                print("space changed")
                // Window moved to a different space
                window.orderFrontRegardless()
            } else {
                print("No window found")
                return
            }
        }
    }
}
