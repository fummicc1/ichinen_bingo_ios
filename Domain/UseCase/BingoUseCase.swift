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
    func makeComplete(bingo: Bingo, at index: Int) async throws
    func revertComplete(bingo: Bingo, at index: Int) async throws
    func fetchList() async throws -> [Bingo]
    func fetchImage() async -> URL
    func buildIntentLink(bingo: Bingo, image: URL?) async throws -> URL
    func onChange() -> AnyPublisher<[Bingo], Never>
}

public enum InvalidBingoError: Error {
    case emptyTitle
    case shortTodoList
}

public enum BingoUseCaseError: Error {
    case invalidParameter
}

public class BingoUseCaseImpl: BingoUseCase {

    public init(localDataStore: LocalDataStore, httpClient: HTTPClient) {
        self.localDataStore = localDataStore
        self.httpClient = httpClient
    }

    private let key: String = "bingos"
    let localDataStore: LocalDataStore
    let httpClient: HTTPClient

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

    public func makeComplete(bingo: Bingo, at index: Int) async throws {
        try await updateIsCompleted(bingo: bingo, at: index, isCompleted: true)
    }

    public func revertComplete(bingo: Bingo, at index: Int) async throws {
        try await updateIsCompleted(bingo: bingo, at: index, isCompleted: false)
    }

    private func updateIsCompleted(bingo: Bingo, at index: Int, isCompleted: Bool) async throws {
        var bingo = bingo
        let todo = bingo.todos[index]
        bingo.todos[todo.index].isCompleted = isCompleted
        var all = try await localDataStore.fetch(key: key, type: [Bingo].self) ?? []
        if let index = all.firstIndex(where: { $0.id == bingo.id }) {
            all[index] = bingo
        }
        try await localDataStore.save(key: key, value: all)
    }

    public func fetchList() async throws -> [Bingo] {
        let all = try await localDataStore.fetch(key: key, type: [Bingo].self) ?? []
        return all
    }

    public func fetchImage() async -> URL {
        fatalError()
    }

    public func buildIntentLink(bingo: Bingo, image: URL?) async throws -> URL {
        fatalError()
    }

    public func onChange() -> AnyPublisher<[Bingo], Never> {
        localDataStore.bingoListStream
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
