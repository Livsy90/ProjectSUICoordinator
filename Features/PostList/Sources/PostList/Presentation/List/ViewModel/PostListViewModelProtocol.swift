//
//  PostListViewModelProtocol.swift
//
//
//  Created by Livsy on 07.04.2024.
//

import Observation

typealias PostListViewModelObservable = PostListViewModelProtocol & Observable

protocol PostListViewModelProtocol: AnyObject {
    var state: PostListState { get }
}
