//
//  PostDetailViewModelProtocol.swift
//
//
//  Created by Livsy on 07.04.2024.
//

import Observation

typealias PostDetailViewModelObservable = PostDetailViewModelProtocol & Observable

protocol PostDetailViewModelProtocol: AnyObject {
    var title: String { get }
}
