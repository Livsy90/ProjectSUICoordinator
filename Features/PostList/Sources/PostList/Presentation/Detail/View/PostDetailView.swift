//
//  PostDetailView.swift
//
//
//  Created by Livsy on 07.04.2024.
//

import SwiftUI
import SwiftPresso
import Router

struct PostDetailView: View {
    
    @Environment(Router.self) private var router
    @State private var viewModel: PostDetailViewModelObservable
    
    init(viewModel: PostDetailViewModelObservable) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Text(viewModel.content)
                    .padding()
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    router.presentSheet(destination: SheetDestination.info(model: "Share"))
                } label: {
                    Image(systemName: "square.and.arrow.up")
                }
            }
        }
    }
    
}
