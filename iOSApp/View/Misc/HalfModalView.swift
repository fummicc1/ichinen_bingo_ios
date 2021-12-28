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

    internal init(root: Root, modal: ModalView, isPresented: Binding<ID?>, onDismiss: @escaping () -> Void) {
        self.root = root
        self.modal = modal
        self._isPresented = isPresented
        self.onDismiss = onDismiss
    }

    let root: Root
    let modal: ModalView
    let onDismiss: () -> Void
    @State private var isShow: Bool = true
    @Binding var isPresented: ID?


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
        if let sheet = contentViewController.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.prefersScrollingExpandsWhenScrolledToEdge = true
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }
        contentViewController.presentationController?.delegate = context.coordinator
        uiViewController.present(contentViewController, animated: true, completion: nil)
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
        isPresented: Binding<ID?>,
        content: (ID) -> Content,
        onDismiss: @escaping () -> Void
    ) -> some View {
        if let model = isPresented.wrappedValue {
            HalfModalView(
                root: self,
                modal: content(model),
                isPresented: isPresented,
                onDismiss: onDismiss
            )
        } else {
            self
        }
    }
}
