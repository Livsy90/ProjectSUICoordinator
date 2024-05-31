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
                                .padding(20)
                                .font(.headline)
                            
                            Divider()
                                .opacity(0)
                        }
                        .padding()
                        .background {
                            ZStack {
                                RoundedRectangle(cornerRadius: 25, style: .continuous)
                                    .fill(.ultraThinMaterial)
                                    .ignoresSafeArea()
                                
                                RoundedRectangle(cornerRadius: 25, style: .continuous)
                                    .fill(
                                        .linearGradient(colors: [
                                            .white.opacity(0.25),
                                            .white.opacity(0.05),
                                            .clear
                                        ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                    )
                                    .blur(radius: 2)
                            }
                            
                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .stroke(
                                    .linearGradient(colors: [
                                        .white.opacity(0.6),
                                        .clear,
                                        .purple.opacity(0.2),
                                        .purple.opacity(0.5)
                                    ], startPoint: .topLeading, endPoint: .bottomTrailing),
                                    lineWidth: 2
                                )
                        }
                        .onTapGesture {
                            router.navigate(to: Destination.postDetails(model: post.text))
                        }
                    }
                }
                .padding()
            }
            .background {
                ZStack {
                    clubbedView()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        router.presentSheet(destination: SheetDestination.menu(model: "This is Modal View"))
                    } label: {
                        Image(systemName: "line.3.horizontal")
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("SwiftUI Coordinator").font(.headline)
                        Text("Demo").font(.subheadline)
                    }
                }
            }
            
        case let .error(error):
            Text(error.localizedDescription)
        }
    }
    
    @ViewBuilder
    private func clubbedView() -> some View {
        Rectangle()
            .fill(.linearGradient(colors: [Color.purple, Color.pink], startPoint: .top, endPoint: .bottom))
            .mask({
                TimelineView(.animation(minimumInterval: 3.6, paused: false)) { _ in
                    Canvas { context, size in
                        context.addFilter(.alphaThreshold(min: 0.5,color: .white))
                        context.addFilter(.blur(radius: 30))
                        context.drawLayer { ctx in
                            for index in 1...15{
                                if let resolvedView = context.resolveSymbol(id: index){
                                    ctx.draw(resolvedView, at: CGPoint(x: size.width / 2, y: size.height / 2))
                                }
                            }
                        }
                    } symbols: {
                        ForEach(1...15,id: \.self){index in
                            let offset = CGSize(width: .random(in: -180...180), height: .random(in: -240...240))
                            clubbedRoundedRectangle(offset: offset)
                                .tag(index)
                        }
                    }
                }
            })
            .contentShape(Rectangle())
    }
    
    @ViewBuilder
    private func clubbedRoundedRectangle(offset: CGSize) -> some View {
        RoundedRectangle(cornerRadius: 30, style: .continuous)
            .fill(.white)
            .frame(width: 120, height: 120)
            .offset(offset)
            .animation(.easeInOut(duration: 4), value: offset)
    }
    
}

