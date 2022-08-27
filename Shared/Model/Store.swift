//
//  Store.swift
//  Spique
//
//  Created by Austin Condiff on 8/28/22.
//

import Foundation

class Store: ObservableObject {
    @Published var phrases: [Phrase] = []
    @Published var selectedPrase: Phrase.ID?
    @Published var showMessages: Bool = true
//    @Published var mode: PhrasesView.ViewMode = .table

    private var applicationSupportDirectory: URL {
        FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
    }

    private var filename = "database.json"

    private var databaseFileUrl: URL {
        applicationSupportDirectory.appendingPathComponent(filename)
    }

    private func loadPhrases(from storeFileData: Data) -> [Phrase] {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode([Phrase].self, from: storeFileData)
        } catch {
            print(error)
            return []
        }
    }

    init() {
        if let data = FileManager.default.contents(atPath: databaseFileUrl.path) {
            phrases = loadPhrases(from: data)
        } else {
            if let bundledDatabaseUrl = Bundle.main.url(forResource: "database", withExtension: "json") {
                if let data = FileManager.default.contents(atPath: bundledDatabaseUrl.path) {
                    phrases = loadPhrases(from: data)
                }
            } else {
                phrases = []
            }
        }
    }

    subscript(phraseID: Phrase.ID?) -> Phrase {
        get {
            if let id = phraseID {
                return phrases.first(where: { $0.id == id }) ?? .placeholder
            }
            return .placeholder
        }

        set(newValue) {
            if let id = phraseID {
                phrases[phrases.firstIndex(where: { $0.id == id })!] = newValue
            }
        }
    }

    func append(_ phrase: Phrase) {
        phrases.append(phrase)
    }

    func save() {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        encoder.outputFormatting = .prettyPrinted
        do {
            let data = try encoder.encode(phrases)
            if FileManager.default.fileExists(atPath: databaseFileUrl.path) {
                try FileManager.default.removeItem(at: databaseFileUrl)
            }
            try data.write(to: databaseFileUrl)
        } catch {
            //..
        }
    }
}

extension Store {
//    func phrases(in year: Int) -> [Phrase] {
//        phrases.filter({ $0.year == year })
//    }
//
//    var currentYear: Int { 2021 }
//
//    var previousYears: ClosedRange<Int> { (2018...2020) }
}
