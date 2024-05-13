//
//  PostListTabCoordinator.swift
//  ProjectSUICoordinator
//
//  Created by Livsy on 07.04.2024.
//

import SwiftUI
import PostList
import Router

struct PostListTabCoordinator: View {
    
    @State var router: Router = .init()
    
    var body: some View {
        NavigationStack(path: $router.navigationPath) {
            PostListCordinator()
        }
        .environment(router)
    }
    
}
