//
//  ToDoItemInputViewDelegateMock.swift
//  ToDoTests
//
//  Created by Shoumik on 09/07/24.
//

import Foundation
@testable import ToDo

class ToDoItemInputViewDelegateMock: ToDoItemInputViewDelegate {
    
    var lastToDoItemData: ToDoItemData?
    var lastCoordinate: Coordinate?
    
    func addToDoItem(with data: ToDo.ToDoItemData,
                     coordinate: ToDo.Coordinate?) {
        lastToDoItemData = data
        lastCoordinate = coordinate
    }
}
