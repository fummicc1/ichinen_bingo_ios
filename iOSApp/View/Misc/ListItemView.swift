//
//  ListItemView.swift
//  iOSApp
//
//  Created by Fumiya Tanaka on 2021/12/28.
//

import SwiftUI

struct ListItemView<Content: View>: View {

    let title: String
    let content: Content
    let onTap: (() -> Void)?

    var body: some View {
        HStack {
            Text(title)
            Spacer()
            content
        }
        .padding()
        .onTapGesture {
            onTap?()
        }
    }
}

struct ListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ListItemView(title: "Test", content: Toggle("Status Update", isOn: .constant(false))) {

        }
    }
}
