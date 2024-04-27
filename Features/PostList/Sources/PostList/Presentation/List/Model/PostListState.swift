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
    case display([DataSource.Post])
    case error(Error)
}
