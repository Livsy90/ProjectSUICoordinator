//
//  PostListViewModel.swift
//
//
//  Created by Livsy on 07.04.2024.
//

import Observation
import SwiftPresso
import Foundation

@Observable
final class PostListViewModel: PostListViewModelProtocol {
    
    var title: String
    var state: PostListState = .loading
    
    private let dataSource = DataSource(host: "intentapp.ru", httpScheme: .https, additionalHeaders: nil)
    
    init(title: String) {
        self.title = title
        
        Task {
            await loadData()
        }
    }
    
    @MainActor
    func loadData() async {
        let result = await dataSource.getPostList(page: 1)
        
        switch result {
        case .success(let postList):
            state = .display(postList)
        case .failure(let error):
            state = .error(error)
        }
    }
    
}

public class DataSource {
    
    private let manager: PostListManagerProtocol
    
    public init(
        host: String,
        httpScheme: HTTPScheme,
        additionalHeaders: [AnyHashable: Any]?
    ) {
        
        manager = SwiftPressoFactory.postListManager(
            host: host,
            httpScheme: httpScheme,
            httpAdditionalHeaders: additionalHeaders
        )
    }
    
    public func getPostList(page: Int) async -> Result<[RefinedPost], Error> {
        do {
            let postList = try await manager.getPosts(pageNumber: page)
            return .success(postList)
        } catch {
            return .failure(error)
        }
    }
    
}

final class Mapper {
    func map(post: RefinedPost) -> [WPPostParts] {
        let mapper = PostDataMapper(htmlMapper: HTMLMapper())
        return mapper.map(htmlString: post.content)
    }
}

extension String {
  func trunc(length: Int, trailing: String = "…") -> String {
    return (self.count > length) ? self.prefix(length) + trailing : self
  }
}

extension URL {
    var isYouTubeURL: Bool {
        let youtubeRegex = "(http(s)?:\\/\\/)?(www\\.|m\\.)?youtu(be\\.com|\\.be)(\\/watch\\?([&=a-z]{0,})(v=[\\d\\w]{1,}).+|\\/[\\d\\w]{1,})"
        let youtubeCheckResult = NSPredicate(format: "SELF MATCHES %@", youtubeRegex)
        return youtubeCheckResult.evaluate(with: absoluteString)
    }
}
