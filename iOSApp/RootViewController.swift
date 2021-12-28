//
//  RootViewController.swift
//  iOSApp
//
//  Created by Fumiya Tanaka on 2021/12/23.
//

import UIKit
import SwiftUI

class RootViewController: UIViewController {

    private var contentHostingController: UIHostingController<RootView>?

    override func viewDidLoad() {
        super.viewDidLoad()
        let controller = UIHostingController(rootView: RootView())
        addChild(controller)
        view.addSubview(controller.view)
        controller.view.frame = view.bounds
        controller.didMove(toParent: self)
        self.contentHostingController = controller
    }
}
