//
//  ContentView.swift
//  Shared
//
//  Created by Austin Condiff on 8/27/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: Store
    @State var searchText: String = ""

    var body: some View {
        NavigationView {
            SidebarView()
                .frame(minWidth: 250)
            HSplitView {
                PhrasesView()
                    .frame(minWidth: 250, maxWidth: .infinity, maxHeight: .infinity)
                if (store.showMessages) {
                    MessagesPanel()
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct MessagesPanel: View {
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 5) {
                    Spacer()
                    Message(text: "Hi, how are you?")
                    Message(text: "That is nice!")
                    Message(text: "I am doing great, thanks for asking.")

                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            HStack {
                Text("Input here")
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.white, lineWidth: 1)
                    )
            }
            .padding()
        }
    }
}

struct Message: View {
    let text: String

    var body: some View {
        Text(text)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(.blue)
            .cornerRadius(20)
    }
}

