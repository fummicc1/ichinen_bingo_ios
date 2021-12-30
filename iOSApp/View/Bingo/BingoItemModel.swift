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
    @Published var screenshot: UIImage?
    @Published var destination: BingoItemView.Destination? = nil

    public init(bingo: Bingo) {
        self.bingo = bingo
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
}
