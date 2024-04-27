//
//  PostDetailView.swift
//
//
//  Created by Livsy on 07.04.2024.
//

import SwiftUI
import SwiftPresso

struct PostDetailView: View {
    
    @State private var viewModel: PostDetailViewModelObservable
    
    init(viewModel: PostDetailViewModelObservable) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.postParts) { object in
                   partView(object)
                }
            }
        }
    }
    
    @ViewBuilder
    private func partView(_ object: WPPostParts) -> some View {
        if object.hasText, let text = object.text {
            Text(text.string)
                .padding()
        } else if let url = object.url, url.isYouTubeURL {
            Link(destination: url) {
                Text("Watch on YouTube")
                    .padding()
            }
        } else if let image = object.image {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
        } else if let url = object.url {
            Link(destination: url) {
                Text(object.text?.string ?? "Link")
                    .padding()
            }
        }
    }
    
}
