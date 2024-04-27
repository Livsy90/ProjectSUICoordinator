//
//  PostListView.swift
//
//
//  Created by Livsy on 07.04.2024.
//

import SwiftUI
import Router

struct PostListView: View {
    
    @Environment(Router.self) private var router
    @State private var viewModel: PostListViewModelObservable
    
    init(viewModel: PostListViewModelObservable) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        switch viewModel.state {
        case .loading:
            ProgressView()
            
        case let .display(postList):
            ScrollView {
                LazyVStack {
                    ForEach(postList, id: \.self) { post in
                        VStack {
                            Text(post.text)
                                .padding()
                                .font(.headline)
                            
                            Divider()
                                .padding()
                        }
                        .onTapGesture {
                            router.navigate(to: Destination.postDetails(model: post.text))
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        router.presentSheet(destination: SheetDestination.menu(model: "Menu"))
                    } label: {
                        Image(systemName: "line.3.horizontal")
                    }
                }
            }
            
        case let .error(error):
            Text(error.localizedDescription)
        }
    }
}
