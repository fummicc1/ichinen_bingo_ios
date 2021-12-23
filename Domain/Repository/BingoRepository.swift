//
//  BingoRepository.swift
//  Domain
//
//  Created by Fumiya Tanaka on 2021/12/23.
//

import Foundation
import SwiftUI

public protocol BingoRepository {
    func create() async throws
    func update(id: Int, bingo: Bingo) async throws
    func fetch(id: Int) async throws -> Bingo
    func delete() async throws
}

public actor BingoRepositoryImpl {
}

extension BingoRepositoryImpl: BingoRepository {
    public func create() async throws {
        fatalError()
    }

    public func update(id: Int, bingo: Bingo) async throws {
        fatalError()
    }

    public func fetch(id: Int) async throws -> Bingo {
        fatalError()
    }

    public func delete() async throws {
        fatalError()
    }


}
