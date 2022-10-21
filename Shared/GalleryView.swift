//
//  GalleryView.swift
//  Spique
//
//  Created by Austin Condiff on 9/12/22.
//

import SwiftUI

struct GalleryView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Gallery coming soon")
            }
            .navigationTitle("Gallery")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView()
    }
}
