//
//  Color.swift
//  iOSApp
//
//  Created by Fumiya Tanaka on 2021/12/28.
//

import Foundation
import SwiftUI

extension Color {

    static var tintColor: Self {
        Color("AccentColor")
    }

    static var textColor: Self {
        Color("TextColor")
    }

    static var secondaryColor: Self {
        Color("SecondaryColor")
    }

    static var backgroundColor: Self {
        Color("BackgroundColor")
    }

    static var secondaryBackgroundColor: Self {
        Color("SecondaryBackgroundColor")
    }

    static var accentTextColor: Self {
        Color("AccentTextColor")
    }
}
