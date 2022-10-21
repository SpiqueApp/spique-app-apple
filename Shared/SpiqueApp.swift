//
//  SpiqueApp.swift
//  Shared
//
//  Created by Austin Condiff on 8/27/22.
//

import SwiftUI

@main
struct SpiqueApp: App {
    @StateObject private var store = Store()
    @StateObject private var obj = observed()

    var body: some Scene {
        WindowGroup {
            #if os(macOS)
            ContentView()
                .frame(minWidth: 500.0, minHeight: 400.0)
                .environmentObject(store)
                .environmentObject(obj)
            #else
            ContentView()
                .environmentObject(store)
            #endif
        }
        .commands {
            SidebarCommands()
        }
    }
}
