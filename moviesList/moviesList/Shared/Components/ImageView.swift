//
//  ImageView.swift
//  moviesList
//
//  Created by Vera Nur on 17.07.2025.
//

import SwiftUI
import Kingfisher

struct ImageView: View {
    let urlString: String?
    var contentMode: SwiftUI.ContentMode = .fit
    var width: CGFloat? = nil
    var height: CGFloat? = nil
    var cornerRadius: CGFloat = 8
    var placeholder: AnyView = AnyView(
        Color.gray.opacity(0.2)
            .overlay(
                ProgressView()
            )
    )
    var isClipped: Bool = false

    var body: some View {
        if let urlString = urlString,
           let url = URL(string: urlString) {
            KFImage(url)
                .placeholder { placeholder }
                .resizable()
                .aspectRatio(contentMode: contentMode)
                .frame(width: width, height: height)
                .cornerRadius(cornerRadius)
                .if(isClipped) { $0.clipped() }
        } else {
            placeholder
                .frame(width: width, height: height)
                .cornerRadius(cornerRadius)
        }
    }
}

extension View {
    @ViewBuilder
    func `if`<Content: View>(
        _ condition: Bool,
        transform: (Self) -> Content
    ) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
