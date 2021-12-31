//
//  SimpleBingoTodoItemView.swift
//  iOSApp
//
//  Created by Fumiya Tanaka on 2021/12/28.
//

import SwiftUI
import Domain

struct SimpleBingoTodoItemView: View {

    @Binding var todo: Bingo.Todo

    var body: some View {
        VStack {
            Text(todo.title)
                .font(.title)
                .bold()
                .multilineTextAlignment(.center)                
                .foregroundColor(Color.tintColor)
            Spacer().frame(height: 24)
            List {
                ListItemView(
                    title: "ステータス",
                    content: Toggle(
                        isOn: $todo.isCompleted,
                        label: {
                            EmptyView()
                        }
                    )
                ) {
                }
            }
        }
        .padding()
        .shadow(radius: 2)
    }
}

struct SimpleBingoItemView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleBingoTodoItemView(todo: .constant(Bingo.Todo.stub))
    }
}
