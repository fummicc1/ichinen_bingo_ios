//
//  BingoItemModel.swift
//  iOSApp
//
//  Created by Fumiya Tanaka on 2021/12/28.
//

import SwiftUI
import Domain

class BingoItemModel: ObservableObject {

    @Published var todoSheet: Bingo.Todo?

    @Published var bingo: Bingo

    public init(bingo: Bingo) {
        self.bingo = bingo
    }
}