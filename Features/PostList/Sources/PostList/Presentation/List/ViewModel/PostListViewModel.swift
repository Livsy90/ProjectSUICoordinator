//
//  PostListViewModel.swift
//
//
//  Created by Livsy on 07.04.2024.
//

import Observation
import WPDataSource
import Foundation

@Observable
final class PostListViewModel: PostListViewModelProtocol {
    
    var title: String
    var state: PostListState = .loading
    
    private let dataSource = WPDataSource(url: URL(string: "https://intentapp.ru/wp-json")!, httpScheme: .https, additionalHeader: nil)
    
    init(title: String) {
        self.title = title
        
        Task {
            await loadData()
        }
    }
    
    @MainActor
    func loadData() async {
        let result = await dataSource.getPostList(page: 1)
        
        switch result {
        case .success(let postList):
            state = .display(postList)
        case .failure(let error):
            state = .error(error)
        }
    }
    
}
