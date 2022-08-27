//
//  SpiqueApp.swift
//  Shared
//
//  Created by Austin Condiff on 8/27/22.
//

import SwiftUI

@main
struct FavoriteThingsApp: App {
    @StateObject private var store = Store()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 500.0, minHeight: 400.0)
                .environmentObject(store)
        }
        .commands {
            SidebarCommands()
        }
    }
}
