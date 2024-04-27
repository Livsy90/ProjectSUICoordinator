//
//  PostListCordinator.swift
//
//
//  Created by Livsy on 07.04.2024.
//

import Router
import SwiftUI
import SwiftPresso

extension WPPostParts: Equatable {
    public static func == (lhs: WPPostParts, rhs: WPPostParts) -> Bool {
        lhs.id == rhs.id
    }
}

extension WPPostParts: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

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
                    PostDetailView(viewModel: PostDetailViewModel(content: model))
                }
            }
            .sheet(item: router.sheetItem) { destination in
                if let destination = destination.destination as? SheetDestination {
                    switch destination {
                    case .info(let model):
                        Text(model)
                            .onTapGesture {
                                router.dismissSheet()
                            }
                    }
                }
            }
    }
}
