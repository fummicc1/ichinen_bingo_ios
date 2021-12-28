//
//  RootViewController.swift
//  iOSApp
//
//  Created by Fumiya Tanaka on 2021/12/23.
//

import UIKit
import SwiftUI

class RootViewController: UIViewController {

    private var contentHostingController: UIHostingController<BingoListView>?

    override func viewDidLoad() {
        super.viewDidLoad()

        let controller = UIHostingController(rootView: BingoListView(bingos: [.stub]))
        addChild(controller)
        view.addSubview(controller.view)
        controller.view.frame = view.bounds
        controller.didMove(toParent: self)

        self.contentHostingController = controller
    }
}
