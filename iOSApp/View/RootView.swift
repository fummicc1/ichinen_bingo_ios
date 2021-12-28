//
//  RootView.swift
//  iOSApp
//
//  Created by Fumiya Tanaka on 2021/12/28.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            BingoItemView(bingo: .stub, model: BingoItemModel())
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
