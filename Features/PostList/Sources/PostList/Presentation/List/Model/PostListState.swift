//
//  PostListState.swift
//
//
//  Created by Livsy on 07.04.2024.
//

import Foundation
import SwiftPresso

enum PostListState {
    case loading
    case display([RefinedPost])
    case error(Error)
}
