//
//  PoetApp.swift
//  Poet
//
//  Created by Eetu Eskelinen on 22.11.2022.
//

import SwiftUI

@main
struct PoetApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject {
    
    private var statusItem: NSStatusItem!
    private var popover: NSPopover!
    
    @MainActor func applicationDidFinishLaunching(_ notification: Notification) {
        
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let statusButton = statusItem.button {
            // Set status bar image
            statusButton.image = NSImage(systemSymbolName: "largecircle.fill.circle", accessibilityDescription: "Circle with number 1")
            
            statusButton.action = #selector(togglePopover)
        }
        self.popover = NSPopover()
        self.popover.contentSize = NSSize(width: 300, height: 300)
        self.popover.behavior = .transient
        self.popover.contentViewController = NSHostingController(rootView: ContentView())
    }
    
    @objc func togglePopover() {
        if let button = statusItem.button {
            if popover.isShown {
                self.popover.performClose(nil);
            } else {
                popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            }
        }
    }
}






// macOS 13 implementation Based on https://sarunw.com/posts/swiftui-menu-bar-app/ by Sarun Wongpatcharapakorn.

//import SwiftUI

//@main
//struct swiftui_menu_barApp: App {
//    @State var currentNumber: String = "1"
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//        MenuBarExtra(currentNumber, systemImage: "\(currentNumber).circle") {
//            Button("One") {
//                currentNumber = "1"
//            }
//            .keyboardShortcut("1")
//            Button("Two") {
//                currentNumber = "2"
//            }
//            .keyboardShortcut("2")
//            Button("Three") {
//                currentNumber = "3"
//            }
//            .keyboardShortcut("3")
//            Divider()

//            Button("Quit") {
//
//                NSApplication.shared.terminate(nil)
//
//            }.keyboardShortcut("q")
//
//        }
//    }
//}
