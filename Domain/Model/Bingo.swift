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
            stub.index = id
            stub.title = "\(id)"
            return stub
        })
    }

    public static func new(title: String) -> Bingo {
        Bingo(id: -1, title: title, todos: [])
    }
}

public extension Bingo {
    struct Todo: Codable, Stubbable, Identifiable, Hashable {
        public init(index: Int, title: String, isCompleted: Bool) {
            self.index = index
            self.title = title
            self.isCompleted = isCompleted
        }

        public var id: Int {
            index
        }

        public var index: Int
        public var title: String
        public var isCompleted: Bool

        public static var stub: Bingo.Todo {
            Bingo.Todo(
                index: 0,
                title: "Stub Title Stub Title Stub Title Stub Title",
                isCompleted: false
            )
        }
    }
}
