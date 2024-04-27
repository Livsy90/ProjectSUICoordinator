//
//  DataSource.swift
//  
//
//  Created by Livsy on 27.04.2024.
//

import Foundation

public class DataSource {
    
    struct Post: Hashable {
        let id = UUID()
        var text: String
    }
    
    var data: [Post] {
        [
            .init(text: generator.generate()),
            .init(text: generator.generate()),
            .init(text: generator.generate()),
            .init(text: generator.generate())
        ]
    }
    
    private let generator = LoremIpsumGenerator()
}
