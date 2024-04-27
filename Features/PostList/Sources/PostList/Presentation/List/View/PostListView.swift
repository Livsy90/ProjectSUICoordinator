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
                                .fill(Color.purple.opacity(0.2))
                                .padding(6)
                            
                            VStack {
                                AsyncImage(url: post.imgURL) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                        
                                    case .success(let image):
                                        image.resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(maxWidth: 80, maxHeight: 80)
                                            .clipShape(Circle())
                                            .padding()
                                        
                                    case .failure:
                                        Image(systemName: "photo")
                                        
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                                .padding(.top, 6)
                                
                                Text(post.excerpt.trunc(length: 100))
                                    .foregroundStyle(.black)
                                    .padding(20)
                            }
                        }
                        .onTapGesture {
                            router.navigate(to: Destination.postDetail(model: Mapper().map(post: post)))
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        router.presentSheet(destination: SheetDestination.info(model: "Menu"))
                    } label: {
                        Image(systemName: "line.3.horizontal")
                    }
                }
             
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        router.presentSheet(destination: SheetDestination.info(model: "Share"))
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
