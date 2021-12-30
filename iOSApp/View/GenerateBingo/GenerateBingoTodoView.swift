//
//  GenerateBingoTodoView.swift
//  iOSApp
//
//  Created by Fumiya Tanaka on 2021/12/31.
//

import SwiftUI

struct GenerateBingoTodoView: View {
    
    @Binding var todos: [String]

    var body: some View {
        TabView {
            ForEach(0..<5) { row -> List in
                VStack {
                    ForEach(0..<5) { column in
                        let index = row * 5 + column
                        let number = index + 1
                        ListItemView(
                            title: "Todo\(number)",
                            content: TextField("\(number)個目のTodoを入力", text: $todos[index]),
                            onTap: nil
                        )
                    }
                }
            }
        }
        .tabViewStyle(.page)
    }
}

struct GenerateBingoTodoView_Previews: PreviewProvider {
    static var previews: some View {
        GenerateBingoTodoView(todos: .constant([]))
    }
}
