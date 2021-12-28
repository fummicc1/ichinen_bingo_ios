//
//  BingoItemView.swift
//  iOSApp
//
//  Created by Fumiya Tanaka on 2021/12/28.
//

import Foundation


import SwiftUI
import Introspect
import Domain

struct BingoItemView: View {

    let bingo: Bingo

    @ObservedObject var model: BingoItemModel

    var body: some View {
        GeometryReader { proxy in
            let width: Double = (proxy.size.width / 5) - Double(5)
            let height: Double = (proxy.size.height / 5) - Double(5)
            let length = min(width, height)
            HStack {
                Spacer()
                LazyVGrid(
                    columns: Array(repeating: GridItem(.fixed(length), spacing: 1), count: 5),
                    spacing: 1
                ) {
                    ForEach(bingo.todos.indices) { index in
                        let todo = bingo.todos[index]
                        let isCenter = (index / 5 == 2) && (index % 5 == 2)
                        element(
                            todo: todo,
                            width: length,
                            height: length,
                            isCenter: isCenter
                        ) { todo in
                            model.todoSheet = todo
                        }
                    }
                }
                Spacer()
            }
        }
        .navigationTitle(bingo.title)
        .font(.largeTitle)
        .foregroundColor(.tintColor)
        .background(Color.backgroundColor)
        .halfModal(identifiable: $model.todoSheet, content: { _ -> SimpleBingoTodoItemView in
            let todo = $model.todoSheet
            return SimpleBingoTodoItemView(todo: Binding(todo)!)
        }) {
            model.todoSheet = nil
        }
    }

    private func element(
        todo: Bingo.Todo,
        width: Double,
        height: Double,
        isCenter: Bool,
        onTap: @escaping (Bingo.Todo) -> Void
    ) -> some View {
        Button {
            onTap(todo)
        } label: {
            VStack {
                Text(todo.title)
                    .font(.caption2)
                    .foregroundColor(Color.black)
                    .bold()
                    .padding()
                    .background(isCenter ? Color.secondaryColor : Color.clear)
                    .clipShape(
                        isCenter ? AnyShape(Circle()) : AnyShape(Rectangle())
                    )
                    .padding(2)
            }
            .background(Color.white).shadow(radius: 2)
            .frame(
                width: width,
                height: height
            )
        }
    }
}

struct BingoItemView_Previews: PreviewProvider {
    static var previews: some View {
        BingoItemView(
            bingo: Bingo.stub,
            model: BingoItemModel()
        )
    }
}
