//
//  MultiLineTextField.swift
//  Spique
//
//  Created by Austin Condiff on 10/7/22.
//

import Foundation
import SwiftUI

struct MultiLineTextField: View {
    var placeholder: String
    @Binding var text: String
    var onFocusChange: (Bool) -> Void
    @State private var alignmentProp: Alignment = .center
    @State private var isFocused: Bool = false

    func handleFocusChange (hasFocus: Bool) {
        onFocusChange(hasFocus)
        alignmentProp = hasFocus ? .leading : .center
    }

    var body: some View {
        ZStack(alignment: alignmentProp) {
            if (text == "") {
                Text(placeholder)
                    .foregroundStyle(.secondary)
                    .padding(4)
            }
            MultiLineTextFieldInside(text: $text, isFocused: $isFocused, onFocusChange: handleFocusChange)
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                    handleFocusChange(hasFocus: false)
                }
        }
        .animation(.easeInOut, value: alignmentProp)
    }
}

struct MultiLineTextFieldInside: UIViewRepresentable {
    @Binding var text: String
    @Binding var isFocused: Bool
    var onFocusChange: (Bool) -> Void

    func makeCoordinator() -> Coordinator {
        return MultiLineTextFieldInside.Coordinator(parent1: self)
    }

    @EnvironmentObject var obj: observed

    func makeUIView(context: UIViewRepresentableContext<MultiLineTextFieldInside>) -> UITextView {
        let view = UITextView()

        view.font = .systemFont(ofSize: UIFont.labelFontSize)
        view.text = text
        view.textColor = .label
        view.backgroundColor = .clear
        view.delegate = context.coordinator
        view.tintColor = .secondaryLabel
        view.isEditable = true
        view.isUserInteractionEnabled = true
        view.textContainer.lineBreakMode = .byTruncatingTail
        view.isScrollEnabled = true

        return view
    }

    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<MultiLineTextFieldInside>) {
        if (uiView.text != text) {
            uiView.text = text
            self.obj.size = uiView.contentSize.height
            if (!self.isFocused) {
                self.isFocused = false
                self.onFocusChange(false)
                uiView.isScrollEnabled = false
            }
        }
    }

    class Coordinator : NSObject, UITextViewDelegate {
        var parent: MultiLineTextFieldInside

        init(parent1: MultiLineTextFieldInside) {
            parent = parent1
        }

        func textViewDidBeginEditing(_ textView: UITextView) {
            self.parent.isFocused = true
            self.parent.onFocusChange(true)
            textView.isScrollEnabled = true
        }

        func textViewDidChange(_ textView: UITextView) {
            self.parent.text = textView.text
            self.parent.obj.size = textView.contentSize.height
            self.parent.isFocused = true
            self.parent.onFocusChange(true)
        }

        func textViewDidEndEditing(_ textView: UITextView) {
            self.parent.isFocused = false
            self.parent.onFocusChange(false)
            textView.isScrollEnabled = false
        }
    }
}

class observed: ObservableObject {
    @Published var text: String = ""
    @Published var size: CGFloat = 37
}
