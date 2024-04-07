//
//  PostDetailView.swift
//
//
//  Created by Livsy on 07.04.2024.
//

import SwiftUI
import Router

struct PostDetailView: View {
    
    @Environment(Router.self) private var router
    @State private var viewModel: PostDetailViewModelObservable
    
    init(viewModel: PostDetailViewModelObservable) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            Text(viewModel.title)
                .onTapGesture {
                    router.presentSheet(destination: SheetDestination.info(model: "Info"))
                }
                .padding()
        }
        .toolbar(.hidden, for: .tabBar)
    }
    
}

#Preview {
    PostDetailView(viewModel: PostDetailViewModel(title: "Test"))
}