//
//  ToDoItemInputView.swift
//  ToDo
//
//  Created by Shoumik on 08/07/24.
//

import SwiftUI

struct ToDoItemInputView: View {
    @ObservedObject var data: ToDoItemData
    @State var withDate = false
    var didAppear: ((Self) -> Void)?
    
    var body: some View {
        VStack {
            TextField("Title", text: $data.title)
            Toggle("Add Date", isOn: $withDate)
            if withDate {
                DatePicker("Date", selection: $data.date)
            }
        }
        .onAppear {
            self.didAppear?(self)
        }
    }
}

#Preview {
    ToDoItemInputView(data: ToDoItemData())
}
