//
//  Bingo.swift
//  Domain
//
//  Created by Fumiya Tanaka on 2021/12/23.
//

import Foundation

public struct Bingo: Codable {
    let id: Int
    let title: String
}

public extension Bingo {
    struct Todo {
        public init(id: Int, title: String, bingoId: Int, isCompleted: Bool) {
            self.id = id
            self.title = title
            self.bingoId = bingoId
            self.isCompleted = isCompleted
        }

        public var id: Int
        public var title: String
        public var bingoId: Int
        public var isCompleted: Bool
    }
}
