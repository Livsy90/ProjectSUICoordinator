//
//  PostDetailViewModelProtocol.swift
//
//
//  Created by Livsy on 07.04.2024.
//

import Observation
import SwiftPresso

typealias PostDetailViewModelObservable = PostDetailViewModelProtocol & Observable

protocol PostDetailViewModelProtocol: AnyObject {
    var postParts: [WPPostParts] { get }
}
