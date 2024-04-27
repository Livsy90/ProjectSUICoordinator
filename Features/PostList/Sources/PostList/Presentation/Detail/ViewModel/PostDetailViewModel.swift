//
//  PostDetailViewModel.swift
//
//
//  Created by Livsy on 07.04.2024.
//

import Observation
import SwiftPresso

@Observable
final class PostDetailViewModel: PostDetailViewModelProtocol {    
    
    var postParts: [WPPostParts]
    
    init(postParts: [WPPostParts]) {
        self.postParts = postParts
    }
    
}
