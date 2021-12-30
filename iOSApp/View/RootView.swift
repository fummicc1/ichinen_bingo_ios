//
//  RootView.swift
//  iOSApp
//
//  Created by Fumiya Tanaka on 2021/12/28.
//

import SwiftUI
import Domain

struct RootView: View {

    @EnvironmentObject var dataStore: LocalDataStoreImpl
    @ObservedObject var model: RootModel

    var body: some View {
        VStack {
            if let latestBingo = model.latestBingo {
                BingoItemView(model: BingoItemModel(bingo: latestBingo))
            } else {
                GenerateBingoView(
                    model: GenerateBingoModel(
                        useCase: BingoUseCaseImpl(
                            localDataStore: dataStore,
                            httpClient: HTTPClientImpl()
                        )
                    )
                )
            }
        }
        .onAppear {
            model.onAppear()
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(
            model: RootModel(
                bingoUseCase: BingoUseCaseImpl(
                    localDataStore: LocalDataStoreImpl(),
                    httpClient: HTTPClientImpl()
                )
            )
        )
    }
}
