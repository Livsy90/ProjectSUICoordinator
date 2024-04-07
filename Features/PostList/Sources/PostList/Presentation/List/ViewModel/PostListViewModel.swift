//
//  PostListViewModel.swift
//
//
//  Created by Livsy on 07.04.2024.
//

import Observation

@Observable
final class PostListViewModel: PostListViewModelProtocol {
    
    var title: String
    
    init(title: String) {
        self.title = title
    }
    
}
