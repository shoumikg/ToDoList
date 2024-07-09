//
//  ToDoItemData.swift
//  ToDo
//
//  Created by Shoumik on 08/07/24.
//

import Foundation

class ToDoItemData: ObservableObject {
    @Published var title = ""
    @Published var date = Date()
    @Published var withDate = false
    @Published var itemDescription = ""
    @Published var locationName = ""
    @Published var addressString = ""
}
