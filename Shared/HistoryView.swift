//
//  HistoryView.swift
//  Spique
//
//  Created by Austin Condiff on 9/12/22.
//

import SwiftUI

struct HistoryView: View {
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
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            HStack {
//                Text("Input here")
//                    .frame(maxWidth: .infinity)
//                    .padding(.horizontal, 12)
//                    .padding(.vertical, 8)
//                    .cornerRadius(20)
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 20)
//                            .stroke(Color.white, lineWidth: 1)
//                    )
//            }
            .padding()
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
