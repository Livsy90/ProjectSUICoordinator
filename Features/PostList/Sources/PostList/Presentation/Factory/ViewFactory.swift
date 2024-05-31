//
//  ViewBuilderFactory.swift
//
//
//  Created by Livsy on 27.04.2024.
//

import SwiftUI

enum ViewKind {
    case postList
    case postDetails(String)
    case share(String)
    case menu(String)
}

struct ViewFactory {
    
    @ViewBuilder
    func view(of kind: ViewKind) -> some View {
        switch kind {
        case .postList:
            PostListView(viewModel: PostListViewModel())
            
        case .postDetails(let model):
            PostDetailsView(viewModel: PostDetailViewModel(content: model))
            
        case .share(let model):
            VStack {
                Text(model)
                    .padding()
                    .foregroundStyle(.white)
                    .font(.subheadline)
                
                Text("Press to close")
                    .padding()
                    .background(.purple)
                    .foregroundStyle(.white)
                    .font(.headline)
                    .cornerRadius(16)
            }
            
        case .menu(let model):
            Text(model)
                .padding()
                .background(.green)
                .foregroundStyle(.white)
                .font(.headline)
                .cornerRadius(16)
        }
    }
    
}
