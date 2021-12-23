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

        public let id: Int
        public let title: String
        public let bingoId: Int
        public let isCompleted: Bool
    }
}
