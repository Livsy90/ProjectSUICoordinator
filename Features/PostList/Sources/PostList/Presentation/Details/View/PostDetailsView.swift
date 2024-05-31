//
//  PostDetailView.swift
//
//
//  Created by Livsy on 07.04.2024.
//

import SwiftUI
import Router

struct PostDetailsView: View {
    
    @Environment(Router.self) private var router
    @State private var viewModel: PostDetailViewModelObservable
    @State private var isTabBarHidden = false
    
    init(viewModel: PostDetailViewModelObservable) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            DynamicGradientView()
            
            ScrollView {
                Text(viewModel.content)
                    .padding()
            }
        }
        .onAppear {
            withAnimation {
                isTabBarHidden.toggle()
            }
        }
        .toolbar(isTabBarHidden ? .hidden : .visible, for: .tabBar)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    router.presentSheet(destination: SheetDestination.share(model: "Modal View"))
                } label: {
                    Image(systemName: "square.and.arrow.up")
                }
            }
        }
    }
    
}
