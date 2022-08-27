//
//  PhraseViewModel.swift
//  Spique
//
//  Created by Austin Condiff on 8/27/22.
//

import SwiftUI

struct Phrase: Codable, Identifiable {
    var id: String
    var text: String
    var color: String
    var tags: [String]
    var emoji: String
}

extension Phrase {
    static var placeholder: Self {
        Phrase(id: UUID().uuidString, text: "", color: "gray", tags: [], emoji: "💬")
    }
}
