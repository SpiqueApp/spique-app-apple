//
//  ContentView.swift
//  Shared
//
//  Created by Austin Condiff on 8/27/22.
//

import SwiftUI
import Introspect

struct ContentView: View {
    @EnvironmentObject var store: Store
    @State var searchText: String = ""

    var body: some View {
        #if os(macOS)
        NavigationView {
            SidebarView()
                .frame(minWidth: 250)
            HSplitView {
                PhrasesView()
                    .frame(minWidth: 250, maxWidth: .infinity, maxHeight: .infinity)
                if (store.showMessages) {
                    HistoryView()
                        .frame(minWidth: 250, idealWidth: 300, maxHeight: .infinity)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .navigationTitle("Spique")
        .searchable(text: $searchText)
        .toolbar {
            Button(action: {
                print("Add")
                withAnimation() {
                    store.showMessages.toggle()
                }
            }) {
                Label("Add Item", systemImage: "plus")
            }
            Toggle(isOn: $store.showMessages) {
                Image(systemName: "waveform.circle")
            }
        }
        #else
        SpiqueTabBar()
        #endif
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

#if os(iOS)

struct Blur: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemChromeMaterial

    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

struct SpiqueTabBar: View {
    private enum Tab: Hashable {
        case phrases
        case history
        case gallery
    }
    @EnvironmentObject var obj: observed
    @State private var text = ""
    @State private var selectedTab: Tab = .phrases

    var body: some View {
        TabView(selection: $selectedTab) {
            Group {
                PhrasesView()
                    .tag(0)
                    .tabItem {
                        Text("Phrases")
                        Image(systemName: "text.bubble.fill")
                    }

                HistoryView()
                    .tag(1)
                    .tabItem {
                        Text("History")
                        Image(systemName: "clock.arrow.circlepath")
                    }

                GalleryView()
                    .tag(2)
                    .tabItem {
                        Text("Gallery")
                        Image(systemName: "sparkles.rectangle.stack.fill")
                    }
            }
            .safeAreaInset(edge: .bottom) {
                SpeakNowBar()
            }
        }
        .scrollDismissesKeyboard(.immediately)
        .navigationTitle("Test")

        .introspectTabBarController { controller in
             controller.tabBar.backgroundImage = .init()
             controller.tabBar.clipsToBounds = true
        }
    }
}

#endif

struct Message: View {
    let text: String

    var body: some View {
        Text(text)
            .foregroundColor(.white)
            .padding(.horizontal, 12)
            .padding(.vertical, 7)
            .background(.blue)
            .cornerRadius(13)
    }
}

