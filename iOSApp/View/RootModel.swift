//
//  RootModel.swift
//  iOSApp
//
//  Created by Fumiya Tanaka on 2021/12/28.
//

import Foundation
import Domain

@MainActor
class RootModel: ObservableObject {

    @Published var latestBingo: Bingo?

    init(bingoUseCase: BingoUseCase) {
        self.bingoUseCase = bingoUseCase
    }

    let bingoUseCase: BingoUseCase

    func onAppear() async {
        do {
           let list = try await bingoUseCase.fetchList()
            guard let latest = list.last else {
                return
            }
            latestBingo = latest
        } catch {
            print(error)
        }
    }
}
