//
//  BingoListView.swift
//  iOSApp
//
//  Created by Fumiya Tanaka on 2021/12/23.
//

import SwiftUI
import Domain

struct BingoListView: View {

    let bingos: [Bingo]

    var body: some View {
        NavigationView {
            List {
                ForEach(bingos) { bingo in
                    NavigationLink(bingo.title) {
                        BingoItemView(bingo: bingo)
                    }
                }
            }
            .navigationTitle("2022年")
        }
    }
}

struct BingoListView_Previews: PreviewProvider {
    static var previews: some View {
        BingoListView(bingos: [
            Bingo.stub
        ])
    }
}
