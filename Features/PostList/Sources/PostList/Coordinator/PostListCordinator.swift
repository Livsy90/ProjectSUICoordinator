//
//  PostListCordinator.swift
//
//
//  Created by Livsy on 07.04.2024.
//

import Router
import SwiftUI

enum Destination: Hashable {
    case postDetail(model: String)
}

enum SheetDestination: Identifiable {
    var id: String {
        switch self {
        case .info:
            return "info"
        }
    }
    
    case info(model: String)
}

public struct PostListCordinator: View {
    @Environment(Router.self) private var router
    
    public init() {}
    
    public var body: some View {
        PostListView(viewModel: PostListViewModel(title: "PostList"))
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case .postDetail(let model):
                    PostDetailView(viewModel: PostDetailViewModel(title: "PostDetail"))
                }
            }
            .sheet(item: router.sheetBinding) { destination in
                if let destination = destination.destination as? SheetDestination {
                    switch destination {
                    case .info(let model):
                        Text(model)
                    }
                }
            }
    }
}
