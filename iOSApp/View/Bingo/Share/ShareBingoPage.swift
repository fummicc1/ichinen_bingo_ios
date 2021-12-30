//
//  ShareBingoPage.swift
//  iOSApp
//
//  Created by Fumiya Tanaka on 2021/12/29.
//

import SwiftUI
import Domain

struct ShareBingoPage: View {

    @ObservedObject var model: ShareBingoModel

    var body: some View {
        VStack {
            Text("シェア画像")
                .font(.title3)
            
            Spacer().frame(height: 48)
        }
    }
}

struct ShareBingoPage_Previews: PreviewProvider {
    static var previews: some View {
        ShareBingoPage(
            model: ShareBingoModel(
                bingo: Bingo.stub,
                useCase: BingoUseCaseImpl(localDataStore: LocalDataStoreImpl(), httpClient: HTTPClientImpl())
            )
        )
    }
}
