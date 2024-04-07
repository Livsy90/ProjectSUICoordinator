//
//  PostListView.swift
//
//
//  Created by Livsy on 07.04.2024.
//

import SwiftUI
import Router

struct PostListView: View {
    
    @State private var viewModel: PostListViewModelObservable
    @Environment(Router.self) private var router
    
    init(viewModel: PostListViewModelObservable) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Text(viewModel.title)
            .onTapGesture {
                router.navigate(to: Destination.postDetail(model: "PostDetail"))
            }
    }
    
}

#Preview {
    PostListView(viewModel: PostListViewModel(title: "Test"))
}
