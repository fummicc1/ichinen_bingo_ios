//
//  GenerateBingoView.swift
//  iOSApp
//
//  Created by Fumiya Tanaka on 2021/12/23.
//

import SwiftUI
import Domain

struct GenerateBingoView: View {

    @ObservedObject var model: GenerateBingoModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            VStack {
                List {
                    if let error = model.error, case InvalidBingoError.emptyTitle = error {
                        Text("無効な入力内容です")
                            .foregroundColor(.red)
                    }
                    ListItemView(
                        title: "タイトル",
                        content: TextField("ビンゴ名を入力", text: $model.title),
                        onTap: nil
                    )
                    if let error = model.error, case InvalidBingoError.shortTodoList = error {
                        Text("入力されていないTodoがあります")
                            .foregroundColor(.red)
                    }
                    GenerateBingoTodoView(todos: $model.todos)
                }
                Spacer()
                Button {
                    model.commit()
                } label: {
                    Text("保存")
                        .foregroundColor(Color.accentTextColor)
                        .font(.title3)
                }
                .padding(.vertical, 12)
                .padding(.horizontal, 32)
                .background(Color.accentColor)
                .cornerRadius(16)
                Spacer()
                    .frame(height: 8)
            }
            .navigationTitle("新規作成")
            .onReceive(model.$closePage) { isClose in
                if isClose {
                    dismiss()
                }
            }
            .background(Color.secondaryBackgroundColor)
        }
    }
}

struct GenerateBingoView_Previews: PreviewProvider {
    static var previews: some View {
        GenerateBingoView(
            model: GenerateBingoModel(
                useCase: BingoUseCaseImpl(
                    localDataStore: LocalDataStoreImpl(),
                    httpClient: HTTPClientImpl()
                )
            )
        )
    }
}
