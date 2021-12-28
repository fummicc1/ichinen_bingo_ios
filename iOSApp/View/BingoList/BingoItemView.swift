//
//  BingoItemView.swift
//  iOSApp
//
//  Created by Fumiya Tanaka on 2021/12/28.
//

import Foundation


import SwiftUI
import Domain

struct BingoItemView: View {

    let bingo: Bingo

    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width / 6
            let height = proxy.size.height / 6
            let length = min(width, height)
            HStack {
                Spacer()
                LazyHGrid(
                    rows: Array(repeating: GridItem(.fixed(length)), count: 5)
                ) {
                    ForEach(bingo.todos.indices) { index in
                        let todo = bingo.todos[index]
                        
                        let isCenter = (index / 5 == 2) && (index % 5 == 2)
                        element(todo: todo, isCenter: isCenter)
                            .frame(
                                width: length,
                                height: length
                            )
                    }
                }
                Spacer()
            }
            .background(Color.accentColor)
        }
    }

    private func element(todo: Bingo.Todo, isCenter: Bool) -> some View {
        VStack {
            Text(todo.title.prefix(5))
                .font(.body)
                .foregroundColor(Color.black)
                .bold()
                .padding()
                .background(isCenter ? Color.clear : Color.accentColor)
                .clipShape(
                    isCenter ? AnyShape(Circle()) : AnyShape(Rectangle())
                )
        }
        .background(Color.white)
    }
}

struct BingoItemView_Previews: PreviewProvider {
    static var previews: some View {
        BingoItemView(bingo: Bingo.stub)
    }
}
