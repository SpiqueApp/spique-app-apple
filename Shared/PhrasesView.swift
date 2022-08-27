//
//  PhrasesView.swift
//  Spique
//
//  Created by Austin Condiff on 8/27/22.
//

import SwiftUI

struct PhrasesView: View {
    @EnvironmentObject var store: Store
    @State var showPhraseDetails = false
    @State var searchText = ""
    @State var showPhrasePopover = false
    let data = (1...100).map { "Item \($0)" }
    let spacing: CGFloat = 12
    var columns: [GridItem] {
        return [
            GridItem(.adaptive(minimum: 136), spacing: spacing)
        ]
    }


    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, alignment: .center, spacing: spacing) {
                ForEach(store.phrases) { phrase in
                    PhraseTileView(showPhraseDetails: $showPhraseDetails, phrase: phrase)
                }
            }
            .padding(.vertical, spacing)
            .padding(.horizontal, spacing + 10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .searchable(text: $searchText)
        .sheet(isPresented: $showPhraseDetails) {
            PhraseDetails()
        }
    }
}

struct PhrasesView_Previews: PreviewProvider {
    static var previews: some View {
        PhrasesView()
    }
}

struct PhraseDetails: View {
    var body: some View {
        Form {
            Section {
                Text("Phrase Details")
                    .padding()
            }
            Section("Test") {
                Text("test")
            }
        }
    }
}
