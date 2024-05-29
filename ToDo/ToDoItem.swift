//
//  ToDoItem.swift
//  ToDo
//
//  Created by Shoumik on 04/05/24.
//

import Foundation

struct ToDoItem: Equatable, Codable {
    static func == (lhs: ToDoItem, rhs: ToDoItem) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: UUID
    let title: String
    let itemDescription: String?
    let timestamp: TimeInterval?
    let location: Location?
    var done = false
    
    init(title: String,
         itemDescription: String? = nil,
         timestamp: TimeInterval? = nil, 
         location: Location? = nil) {
        self.id = UUID()
        self.title = title
        self.itemDescription = itemDescription
        self.timestamp = timestamp
        self.location = location
    }
}

extension ToDoItem: Hashable {
    func hash(into hasher:   inout Hasher) {
        hasher.combine(id)
    }
}
