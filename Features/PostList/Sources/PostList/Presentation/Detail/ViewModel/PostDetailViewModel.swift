//
//  PostDetailViewModel.swift
//
//
//  Created by Livsy on 07.04.2024.
//

import Observation

@Observable
final class PostDetailViewModel: PostDetailViewModelProtocol {
    
    var title: String
    
    init(title: String) {
        self.title = title
    }
    
}
