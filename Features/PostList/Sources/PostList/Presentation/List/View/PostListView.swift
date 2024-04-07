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
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    
    init(viewModel: PostListViewModelObservable) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        switch viewModel.state {
        case .loading:
            EmptyView()
            
        case let .display(postList):
            ScrollView {
                LazyVGrid(columns: columns, alignment: .leading, spacing: 8) {
                    ForEach(postList, id: \.id) { post in
                        Text(post.excerpt)
                            .onTapGesture {
                                router.navigate(to: Destination.postDetail(model: post.content))
                            }
                            .padding()
                    }
                }
            }
            
        case .error:
            EmptyView()
        }
    }
}



#Preview {
    PostListView(viewModel: PostListViewModel(title: "Test"))
}
