//
//  PostListState.swift
//
//
//  Created by Livsy on 07.04.2024.
//

import Foundation
import WPDataSource

enum PostListState {
    case loading
    case display([Post])
    case error(Error)
}
