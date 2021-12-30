//
//  RootViewController.swift
//  iOSApp
//
//  Created by Fumiya Tanaka on 2021/12/23.
//

import UIKit
import SwiftUI
import Domain

class RootViewController: UIViewController {

    private var contentHostingController: UIHostingController<AnyView>?

    override func viewDidLoad() {
        super.viewDidLoad()
        let dataStore = LocalDataStoreImpl()
        let controller = UIHostingController(
            rootView: AnyView(
                RootView(
                    model: RootModel(
                        bingoUseCase: BingoUseCaseImpl(
                            localDataStore: dataStore,
                            httpClient: HTTPClientImpl()
                        )
                    )
                ).environmentObject(dataStore)
            )
        )
        addChild(controller)
        view.addSubview(controller.view)
        controller.view.frame = view.bounds
        controller.didMove(toParent: self)
        self.contentHostingController = controller
    }
}
