//
//  SpeakNowBar.swift
//  Spique
//
//  Created by Austin Condiff on 10/7/22.
//

import SwiftUI

struct SpeakNowBar: View {
    @StateObject private var obj = observed()
    @EnvironmentObject var store: Store
    @State private var text: String = ""
    @State private var isFocused: Bool = false
    @State private var horizontalPadding: CGFloat = 20

    let verticalPadding: CGFloat = 10
    let font = UIFont.systemFont(ofSize: UIFont.labelFontSize)
    var lineHeight: CGFloat = 21
    let minHeight: CGFloat = 37;
    var maxHeight: CGFloat = 128;
    let maxLines: CGFloat = 5;

    init() {
        self.lineHeight = font.lineHeight
        self.maxHeight = lineHeight * maxLines + verticalPadding * 2
    }

    func handleFocusChange (hasFocus: Bool) {
        isFocused = hasFocus
        horizontalPadding = isFocused ? 10 : 20
        print(lineHeight)
    }

    var body: some View {
        HStack(alignment: .bottom) {
            HStack {
                MultiLineTextField(placeholder: "Type to speak", text: $store.speakNowText, onFocusChange: handleFocusChange)
                    .environmentObject(obj)
                    .frame(height: isFocused ? self.obj.size < maxHeight ? self.obj.size : maxHeight : minHeight)
                    .padding(.horizontal, 8)
                    .foregroundStyle(.primary)
                    .background(Color(uiColor: .quaternaryLabel))
                    .cornerRadius(10)
            }
            if (store.speakNowText != "") {
                Button(action: {
                    print("Play tapped!")
                    store.speakNowText = ""
                }) {
                    HStack {
                        Image(systemName: "play.fill")
                    }
                    .frame(width: minHeight, height: minHeight)
                    .foregroundColor(.white)
                    .background(.tint)
                    .cornerRadius(10)
                }
            }

        }
        .padding(.horizontal, horizontalPadding)
        .padding(.vertical, verticalPadding)
        .background(.regularMaterial)
        .animation(.easeInOut, value: horizontalPadding)
    }
}

struct SpeakNowBar_Previews: PreviewProvider {
    static var previews: some View {
        SpeakNowBar()
    }
}

struct PressActions: ViewModifier {
    var onPress: () -> Void
    var onRelease: () -> Void

    func body(content: Content) -> some View {
        content
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({ _ in
                        onPress()
                    })
                    .onEnded({ _ in
                        onRelease()
                    })
            )
    }
}

extension View {
    func pressAction(onPress: @escaping (() -> Void), onRelease: @escaping (() -> Void)) -> some View {
        modifier(PressActions(onPress: {
            onPress()
        }, onRelease: {
            onRelease()
        }))
    }
}

