//
//  LocalDataStore.swift
//  Domain
//
//  Created by Fumiya Tanaka on 2021/12/28.
//

import Foundation

public protocol LocalDataStore {
    func save<Value: Codable>(key: String, value: Value) async throws
    func fetch<Value: Codable>(key: String, type: Value.Type) async throws -> Value?
}

public actor LocalDataStoreImpl: ObservableObject, LocalDataStore {


    // TODO: Move reponsibility to other object
    @MainActor @Published var bingoList: [Bingo] = []


    let database: UserDefaults

    public init(database: UserDefaults = .standard) {
        self.database = database
    }

    public func save<Value>(key: String, value: Value) async throws where Value : Decodable, Value : Encodable {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let data = try encoder.encode(value)
        let text = String(data: data, encoding: .utf8)
        database.set(text, forKey: key)
        await sync()
    }

    public func fetch<Value>(key: String, type: Value.Type) async throws -> Value? where Value : Decodable, Value : Encodable {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let raw = database.string(forKey: key), let data = raw.data(using: .utf8) else {
            return nil
        }
        let value = try decoder.decode(Value.self, from: data)
        return value
    }

    private func sync() async {
        if let bingoList = try? await fetch(key: "bingos", type: [Bingo].self) {
            await MainActor.run {
                self.bingoList = bingoList
            }
        }
    }
}


