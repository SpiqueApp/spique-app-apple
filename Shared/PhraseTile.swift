//
//  PhrasesTileView.swift
//  Spique
//
//  Created by Austin Condiff on 8/28/22.
//

import SwiftUI
import AVFoundation

struct PhraseTile: View {
    @EnvironmentObject var store: Store
    @State var showPhrasePopover: Bool = false
    @Binding var showPhraseDetails: Bool
    let phrase: Phrase;
    

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(
                    colors: [
                        .white.opacity(0.2),
                        .white.opacity(0.0)
                    ]
                ),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            VStack(alignment: .leading, spacing: 5) {
                HStack{
                    Text(phrase.emoji)
                        .font(.system(size: 20))
                }
                Spacer()
                Text(phrase.text)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)

            }
            .padding(10)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .frame(height: 94)
        .background(Color(phrase.color))
        .foregroundColor(.white)
        .cornerRadius(15)
        .onTapGesture {
            let utterance = AVSpeechUtterance(string: phrase.text)
            utterance.voice = AVSpeechSynthesisVoice(identifier: "com.apple.speech.synthesis.voice.samantha.premium")
            utterance.pitchMultiplier = 1
            utterance.rate = 0.3
            let synthesizer = AVSpeechSynthesizer()
            synthesizer.speak(utterance)
        }
        .contextMenu {
            Button(action: {}) {
                Text("Speak")
            }
            Button(action: {}) {
                Text("Copy")
            }
            Button(action: {
                showPhraseDetails = true
            }) {
                Text("Edit")
            }
            Button(action: {
                showPhrasePopover = true
            }) {
                Text("Change Color")
            }

        }
        .popover(isPresented: $showPhrasePopover) {
            PhraseDetails()
        }

    }
}

struct PhrasesTileView_Previews: PreviewProvider {
    @State static var showPhraseDetails = false

    static var previews: some View {
        PhraseTile(showPhraseDetails: $showPhraseDetails, phrase: Phrase(id: "123", text: "The quick brown fox jumped over the lazy dog.", color: "orange", tags: ["test"], emoji: "💬"))
            .frame(width: 190.0)
    }
}
