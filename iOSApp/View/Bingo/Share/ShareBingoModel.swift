//
//  ShareBingoModel.swift
//  iOSApp
//
//  Created by Fumiya Tanaka on 2021/12/29.
//

import Foundation
import SwiftUI
import Domain

class ShareBingoModel: ObservableObject {

    public init(bingo: Bingo, useCase: BingoUseCase) {
        self.bingo = bingo
        self.useCase = useCase
    }

    let useCase: BingoUseCase
    let bingo: Bingo
    @Published var error: Error?
    @Published var imageURL: String?

    func fetchImage() async {

    }

    func commit() async {
        do {
            let url = try await useCase.buildIntentLink(bingo: bingo)
            await UIApplication.shared.open(url, options: [.universalLinksOnly: true])
        } catch {
            self.error = error
        }
    }
}
