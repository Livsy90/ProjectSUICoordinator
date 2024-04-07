//
//  PostListViewModelProtocol.swift
//
//
//  Created by Livsy on 07.04.2024.
//

import Observation

typealias PostListViewModelObservable = PostListViewModelProtocol & Observable

protocol PostListViewModelProtocol: AnyObject {
    var title: String { get }
    var state: PostListState { get }
    
    func loadData() async
}