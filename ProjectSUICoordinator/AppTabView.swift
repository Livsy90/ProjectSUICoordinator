//
//  AppTabView.swift
//  ProjectSUICoordinator
//
//  Created by Livsy on 07.04.2024.
//

import SwiftUI

struct AppTabView: View {
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            PostListTabCoordinator()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                        .tag(0)
                }
        }
    }
}

