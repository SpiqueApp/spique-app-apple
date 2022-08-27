//
//  SidebarView.swift
//  Spique
//
//  Created by Austin Condiff on 8/27/22.
//

import SwiftUI

struct SidebarView: View {
    func addItem() {
        print("adding item")
    }

    var body: some View {
        List() {
            Label("Gallery", systemImage: "square.2.stack.3d")

            Section("My Phrases") {
                Label("All Phrases", systemImage: "rectangle.grid.2x2")
                Label("Quick Responses", systemImage: "message")
                Label("Custom Phrases", systemImage: "rectangle.grid.2x2")
            }

            Section("Folders") {
                Label("Travel", systemImage: "folder")
                Label("Hospital", systemImage: "folder")
                Label("Food & Dining", systemImage: "folder")
            }

            Section("Tags") {
                Label("Positive", systemImage: "tag")
                Label("Negative", systemImage: "tag")
                Label("Question", systemImage: "tag")
                Label("Greeting", systemImage: "tag")
                Label("Feeling", systemImage: "tag")
                Label("Reaction", systemImage: "tag")
                Label("Request", systemImage: "tag")
                Label("Urgent", systemImage: "tag")
                Label("Affirmation", systemImage: "tag")
            }

            Section("Colors") {
                Label {
                    Text("Red")
                } icon: {
                    Image(systemName: "circlebadge.fill")
                        .foregroundColor(.red)
                }
                Label {
                    Text("Orange")
                } icon: {
                    Image(systemName: "circlebadge.fill")
                        .foregroundColor(.orange)
                }
                Label {
                    Text("Yellow")
                } icon: {
                    Image(systemName: "circlebadge.fill")
                        .foregroundColor(.yellow)
                }
                Label {
                    Text("Green")
                } icon: {
                    Image(systemName: "circlebadge.fill")
                        .foregroundColor(.green)
                }
                Label {
                    Text("Teal")
                } icon: {
                    Image(systemName: "circlebadge.fill")
                        .foregroundColor(.teal)
                }
                Label {
                    Text("Blue")
                } icon: {
                    Image(systemName: "circlebadge.fill")
                        .foregroundColor(.blue)
                }
                Label {
                    Text("Purple")
                } icon: {
                    Image(systemName: "circlebadge.fill")
                        .foregroundColor(.purple)
                }
                Label {
                    Text("Pink")
                } icon: {
                    Image(systemName: "circlebadge.fill")
                        .foregroundColor(.pink)
                }
                Label {
                    Text("Gray")
                } icon: {
                    Image(systemName: "circlebadge.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .toolbar {
            Button(action: toggleSidebar) {
                Label("Toggle Sidebar", systemImage: "sidebar.leading")
            }
            .help("Toggle Sidebar")
        }
    }

    private func toggleSidebar() {
        #if os(macOS)
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
        #endif
    }
}

struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView()
    }
}
