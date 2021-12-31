//
//  BingoItemModel.swift
//  iOSApp
//
//  Created by Fumiya Tanaka on 2021/12/28.
//

import SwiftUI
import Domain
import Combine

class BingoItemModel: ObservableObject {

    @Published var todoSheet: Bingo.Todo?
    @Published var bingo: Bingo
    @Published var screenshot: UIImage?
    @Published var destination: BingoItemView.Destination? = nil

    private let useCase: BingoUseCase
    private var cancellables: Set<AnyCancellable> = []

    public init(bingo: Bingo, useCase: BingoUseCase) {
        self.bingo = bingo
        self.useCase = useCase

        _todoSheet.projectedValue
            .compactMap({ $0 })
            .removeDuplicates()
            .sink { todo in
                self.onChangeIsCompleted(todo: todo)
            }
            .store(in: &cancellables)
    }

    func share() {
        guard let keyWindow = UIApplication.shared.connectedScenes
                .compactMap({ $0 as? UIWindowScene })
                .first(where: { $0.activationState == .foregroundActive }) else {
                    return
                }
        guard let keyWindow = keyWindow.keyWindow else {
            return
        }
        let renderer = UIGraphicsImageRenderer(bounds: keyWindow.bounds)
        let image = renderer.image { context in
            keyWindow.layer.render(in: context.cgContext)
        }
        destination = .share
        screenshot = image
    }

    func onChangeIsCompleted(todo: Bingo.Todo) {
        Task {
            let isCompleted = todo.isCompleted
            guard let index = bingo.todos.firstIndex(where: { $0.index == todo.index }) else {
                return
            }
            if isCompleted {
                try await useCase.makeComplete(bingo: bingo, at: index)
            } else {
                try await useCase.revertComplete(bingo: bingo, at: index)
            }
            bingo.todos[index] = todo
        }
    }
}
