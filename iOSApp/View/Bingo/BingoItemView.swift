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

    @EnvironmentObject var dataStore: LocalDataStoreImpl
    @ObservedObject var model: BingoItemModel

    var body: some View {
        NavigationView {
            content()
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("人生ビンゴ")
                .halfModal(identifiable: $model.todoSheet, content: { _ -> SimpleBingoTodoItemView in
                    let todo = $model.todoSheet
                    return SimpleBingoTodoItemView(todo: Binding(todo)!)
                }) {
                    model.todoSheet = nil
                }
                .sheet(item: $model.destination, onDismiss: {
                    model.destination = nil
                }, content: { destination in
                    switch destination {
                    case .new:
                        GenerateBingoView(
                            model: GenerateBingoModel(
                                useCase: BingoUseCaseImpl(
                                    localDataStore: LocalDataStoreImpl(),
                                    httpClient: HTTPClientImpl()
                                )
                            )
                        )
                    case .share:
                        ActivityController(items: [model.bingo.title, model.screenshot as Any], activities: nil)
                    }
                })
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button {
                            model.share()
                        } label: {
                            Image(systemName: "square.and.arrow.up")
                                .font(.body)
                        }
                        Button {
                            model.destination = .new
                        } label: {
                            Image(systemName: "plus")
                                .font(.body)
                        }
                    }
                }
        }
    }

    private func content() -> some View {
        VStack {
            Text("<タイトル: \(model.bingo.title)>")
                .font(.title2)
                .multilineTextAlignment(.center)
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
                        ForEach((0..<25)) { index in
                            let todo = model.bingo.todos[index]
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
        }
        .background(Color.backgroundColor)
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
            ZStack {
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
                    .frame(
                        width: width,
                        height: height
                    )
                if todo.isCompleted {
                    Circle()
                        .stroke(lineWidth: 4)
                        .foregroundColor(Color.red)
                        .padding(4)
                }
            }
        }
        .frame(
            width: width,
            height: height
        )
        .background(Color.white)
        .clipShape(Rectangle())
        .shadow(radius: 2)
    }
}

extension BingoItemView {
    enum Destination: String, Identifiable {
        var id: Int {
            hashValue
        }
        case new
        case share
    }
}

struct BingoItemView_Previews: PreviewProvider {
    static var previews: some View {
        BingoItemView(
            model: BingoItemModel(
                bingo: Bingo.stub,
                useCase: BingoUseCaseImpl(
                    localDataStore: LocalDataStoreImpl(),
                    httpClient: HTTPClientImpl()
                )
            )
        )
    }
}
