//
//  PhrasesView.swift
//  Spique
//
//  Created by Austin Condiff on 8/27/22.
//

import SwiftUI

struct PhraseListView: View {
    @EnvironmentObject var store: Store
    @State var showPhraseDetails = false
    @State var searchText = ""
    @State var showPhrasePopover = false
    let data = (1...100).map { "Item \($0)" }
    let spacing: CGFloat = 10
    var columns: [GridItem] {
        return [
            GridItem(.adaptive(minimum: 136), spacing: spacing)
        ]
    }


    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, alignment: .center, spacing: spacing) {
                ForEach(store.phrases) { phrase in
                    PhraseTile(showPhraseDetails: $showPhraseDetails, phrase: phrase)
                }
            }
            .padding(.horizontal, spacing + 10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .searchable(text: $searchText)
        .sheet(isPresented: $showPhraseDetails) {
            PhraseDetails()
        }
    }
}

struct PhraseListView_Previews: PreviewProvider {
    static var previews: some View {
        PhraseListView()
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
