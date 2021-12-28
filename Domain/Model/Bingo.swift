//
//  Bingo.swift
//  Domain
//
//  Created by Fumiya Tanaka on 2021/12/23.
//

import Foundation

public struct Bingo: Codable, Stubbable, Identifiable, Hashable {
    public let id: Int
    public let title: String
    public let todos: [Bingo.Todo]

    public static var stub: Bingo {
        Bingo(
            id: 0,
            title: "Stub Bingo",
            todos: todosStub
        )
    }

    private static var todosStub: [Todo] {
        (0..<25).map({ id in
            var stub = Todo.stub
            stub.id = id
            stub.index = id
            return stub
        })
    }
}

public extension Bingo {
    struct Todo: Codable, Stubbable, Identifiable, Hashable {
        public init(id: Int, index: Int, title: String, bingoId: Int, isCompleted: Bool) {
            self.id = id
            self.index = index
            self.title = title
            self.bingoId = bingoId
            self.isCompleted = isCompleted
        }

        public var id: Int
        public var index: Int
        public var title: String
        public var bingoId: Int
        public var isCompleted: Bool

        public static var stub: Bingo.Todo {
            Bingo.Todo(
                id: 0,
                index: 0,
                title: "Stub Title Stub Title Stub Title Stub Title",
                bingoId: 0,
                isCompleted: false
            )
        }
    }
}
