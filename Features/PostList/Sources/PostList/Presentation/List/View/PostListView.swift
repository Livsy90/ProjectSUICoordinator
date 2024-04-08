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
            ProgressView()
            
        case let .display(postList):
            ScrollView {
                LazyVGrid(columns: columns, alignment: .leading, spacing: 4) {
                    ForEach(postList, id: \.id) { post in
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.black.opacity(0.4))
                                .padding(6)
                            
                            VStack {
                                AsyncImage(url: post.imgURL) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                        
                                    case .success(let image):
                                        image.resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(maxWidth: 100, maxHeight: 80)
                                        
                                    case .failure:
                                        Image(systemName: "photo")
                                        
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                                .padding(.top, 6)
                                
                                Text(post.excerpt)
                                    .foregroundStyle(.white)
                                    .padding(20)
                            }
                        }
                        .onTapGesture {
                            router.navigate(to: Destination.postDetail(model: post.content))
                        }
                    }
                }
            }
            .toolbarBackground(.green)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        // action
                    } label: {
                        Image(systemName: "line.3.horizontal")
                    }
                }
             
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        // action
                    } label: {
                        Image(systemName: "plus")
                    }
                }
             
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        // action
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                    }
                }
            }
            
        case let .error(error):
            Text(error.localizedDescription)
        }
    }
}

#Preview {
    PostListView(viewModel: PostListViewModel(title: "Test"))
}
