//
//  PostListViewModel.swift
//
//
//  Created by Livsy on 07.04.2024.
//

import Observation
import SwiftPresso
import Foundation

@Observable
final class PostListViewModel: PostListViewModelProtocol {
    
    private(set) var state: PostListState = .loading
    
    private let dataSource = DataSource()
    
    init() {
        Task {
            try await Task.sleep(for: .seconds(2))
            await loadData()
        }
    }
    
    @MainActor
    private func loadData() {
        state = .display(dataSource.data)
    }
    
}
