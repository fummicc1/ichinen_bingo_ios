//
//  HalfModalView.swift
//  iOSApp
//
//  Created by Fumiya Tanaka on 2021/12/28.
//

import Foundation
import UIKit
import SwiftUI

struct HalfModalView<Root: View, ModalView: View, ID: Identifiable>: UIViewControllerRepresentable {

    internal init(root: Root, modal: ModalView, model: Binding<ID?>, onDismiss: @escaping () -> Void) {
        self.root = root
        self.modal = modal
        self._model = model
        self.onDismiss = onDismiss
    }

    let root: Root
    let modal: ModalView
    let onDismiss: () -> Void
    @State private var isShow: Bool = true
    @Binding var model: ID?


    func makeUIViewController(context: Context) -> some UIViewController {
        UIHostingController(rootView: root)
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {

        if !isShow {
            uiViewController.dismiss(animated: true) {
                onDismiss()
            }
            return
        }
        let contentViewController = UIHostingController(rootView: modal)
        if uiViewController.presentedViewController != nil {
            return
        }
        contentViewController.modalPresentationStyle = .pageSheet
        if let sheet = contentViewController.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.largestUndimmedDetentIdentifier = .none
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersGrabberVisible = true
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }
        contentViewController.presentationController?.delegate = context.coordinator
        DispatchQueue.main.async {
            uiViewController.present(contentViewController, animated: true, completion: nil)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(isShow: $isShow)
    }

    class Coordinator: NSObject, UIAdaptivePresentationControllerDelegate {

        init(isShow: Binding<Bool>) {
            self._isShow = isShow
            super.init()
        }

        @Binding var isShow: Bool


        func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
            isShow = false
        }
    }
}

extension View {
    @ViewBuilder
    func halfModal<Content: View, ID: Identifiable>(
        identifiable: Binding<ID?>,
        content: (ID) -> Content,
        onDismiss: @escaping () -> Void
    ) -> some View {
        if let model = identifiable.wrappedValue {
            background(
                HalfModalView(
                    root: self,
                    modal: content(model),
                    model: identifiable,
                    onDismiss: onDismiss
                )
            )
        } else {
            self
        }
    }
}
