//
//  ToDoItemInputView.swift
//  ToDo
//
//  Created by Shoumik on 08/07/24.
//

import SwiftUI

protocol ToDoItemInputViewDelegate {
    func addToDoItem(with: ToDoItemData,
                     coordinate: Coordinate?)
}

struct ToDoItemInputView: View {
    @ObservedObject var data: ToDoItemData
    let apiClient: APIClientProtocol
    var delegate: ToDoItemInputViewDelegate?
    
    var body: some View {
        Form {
            SwiftUI.Section {
                TextField("Title", text: $data.title)
                Toggle("Add Date", isOn: $data.withDate)
                if data.withDate {
                    DatePicker("Date", selection: $data.date)
                }
                TextField("Description",
                          text: $data.itemDescription)
            }
            SwiftUI.Section {
                TextField("Location name",
                          text: $data.locationName)
                TextField("Address", text: $data.addressString)
            }
            SwiftUI.Section {
                Button(action: addToDoItem) {
                    Text("Save")
                }
            }
        }
    }
    
    func addToDoItem() {
        if false == data.addressString.isEmpty {
            apiClient.coordinate(
                for: data.addressString,
                completion: { coordinate in
                    self.delegate?.addToDoItem(
                        with: data,
                        coordinate: coordinate)
                })
        } else {
            delegate?.addToDoItem(with: data,
                                  coordinate: nil)
        }
    }
}

#Preview {
    ToDoItemInputView(data: ToDoItemData(), 
                      apiClient: APIClient())
        .previewLayout(.sizeThatFits)
}
