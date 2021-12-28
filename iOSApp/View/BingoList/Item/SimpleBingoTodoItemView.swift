//
//  SimpleBingoTodoItemView.swift
//  iOSApp
//
//  Created by Fumiya Tanaka on 2021/12/28.
//

import SwiftUI
import Domain

struct SimpleBingoTodoItemView: View {

    let todo: Bingo.Todo

    var body: some View {
        VStack {
            Text(todo.title)
                .font(.title)
                .bold()
                .multilineTextAlignment(.center)                
                .foregroundColor(Color.tintColor)
            Spacer().frame(height: 24)
            List {
                HStack {
                    Text("ステータス")
                    CheckBox(isChecked: todo.isCompleted)
                }
            }
        }
        .padding()
        .shadow(radius: 2)
    }
}

struct SimpleBingoItemView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleBingoTodoItemView(todo: Bingo.Todo.stub)
    }
}
