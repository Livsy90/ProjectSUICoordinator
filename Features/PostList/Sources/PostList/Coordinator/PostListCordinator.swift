//
//  PostListCordinator.swift
//
//
//  Created by Livsy on 07.04.2024.
//

import Router
import SwiftUI

enum Destination: Hashable {
    case postDetails(model: String)
}

enum SheetDestination: Identifiable {
    var id: String {
        switch self {
        case .menu: "menu"
        case .share: "share"
        }
    }
    
    case menu(model: String)
    case share(model: String)
}

public struct PostListCordinator: View {
    @Environment(Router.self) private var router
    
    public init() {}
    
    public var body: some View {
        ViewFactory().view(of: .postList)
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case .postDetails(let model):
                    ViewFactory().view(of: .postDetails(model))
                }
            }
            .sheet(item: router.sheetItem) { destination in
                if let destination = destination.destination as? SheetDestination {
                    switch destination {
                    case .menu(let model):
                        ViewFactory().view(of: .menu(model))
                            .onTapGesture {
                                router.dismissSheet()
                            }
                    case .share(let model):
                        ViewFactory().view(of: .share(model))
                            .onTapGesture {
                                router.dismissSheet()
                            }
                    }
                }
            }
    }
    
}
