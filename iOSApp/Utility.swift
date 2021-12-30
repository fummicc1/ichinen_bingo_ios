//
//  Utility.swift
//  iOSApp
//
//  Created by Fumiya Tanaka on 2021/12/28.
//

import SwiftUI

// https://stackoverflow.com/questions/62602166/how-to-use-same-set-of-modifiers-for-various-shapes/62605936#62605936
struct AnyShape: Shape {
    private let builder: (CGRect) -> Path

    init<S: Shape>(_ shape: S) {
        builder = { rect in
            let path = shape.path(in: rect)
            return path
        }
    }

    func path(in rect: CGRect) -> Path {
        return builder(rect)
    }
}

struct ActivityController: UIViewControllerRepresentable {
    let items: [Any]
    let activities: [UIActivity]?

    func makeUIViewController(context: Context) -> some UIViewController {
        UIActivityViewController(
            activityItems: items,
            applicationActivities: activities
        )
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}
