//
//  BingoUseCase.swift
//  Domain
//
//  Created by Fumiya Tanaka on 2021/12/28.
//

import Foundation
import Combine

public protocol BingoUseCase {
    func validate(title: String, todos: [String]) -> InvalidBingoError?
    func add(title: String, todos: [String]) async throws
    func fetchList() async throws -> [Bingo]
    func onChange() -> AnyPublisher<[Bingo], Never>
}

public enum InvalidBingoError: Error {
    case emptyTitle
    case shortTodoList
}

public class BingoUseCaseImpl: BingoUseCase {

    public init(localDataStore: LocalDataStore) {
        self.localDataStore = localDataStore
    }

    private let key: String = "bingos"
    let localDataStore: LocalDataStore

    public func validate(title: String, todos: [String]) -> InvalidBingoError? {
        if title.isEmpty {
            return .emptyTitle
        }
        if todos.count < 25 {
            return .shortTodoList
        }
        if todos.allSatisfy({ !$0.isEmpty }) == false {
            return .shortTodoList
        }
        return nil
    }

    public func add(title: String, todos: [String]) async throws {
        var all = try await localDataStore.fetch(key: key, type: [Bingo].self) ?? []
        let bingo = Bingo(
            id: all.count,
            title: title,
            todos: todos.enumerated().map({ (index, text) in
                Bingo.Todo(index: index, title: text, isCompleted: false)
            })
        )
        all.append(bingo)
        try await localDataStore.save(key: key, value: all)
    }

    public func fetchList() async throws -> [Bingo] {
        let all = try await localDataStore.fetch(key: key, type: [Bingo].self) ?? []
        return all
    }

    public func onChange() -> AnyPublisher<[Bingo], Never> {
        localDataStore.bingoListStream
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
