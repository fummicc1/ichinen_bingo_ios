//
//  GenerateBingoModel.swift
//  iOSApp
//
//  Created by Fumiya Tanaka on 2021/12/28.
//

import Foundation
import Domain

@MainActor
class GenerateBingoModel: ObservableObject {

    init(useCase: BingoUseCase) {
        self.useCase = useCase
    }


    @Published var title: String = ""
    @Published var error: Error?
    @Published var closePage: Bool = false

    @Published var todos: [String] = (0..<25).map({ _ in "テスト" })

    let useCase: BingoUseCase

    func commit() {
        if let error = useCase.validate(title: title, todos: todos) {
            self.error = error
            return
        }
        error = nil
        Task {
            try await useCase.add(title: title, todos: todos)
            closePage = true
        }
    }
}
