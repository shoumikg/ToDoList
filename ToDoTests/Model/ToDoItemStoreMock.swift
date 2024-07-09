//
//  ToDoItemStoreMock.swift
//  ToDoTests
//
//  Created by Shoumik on 07/05/24.
//

import Foundation
import Combine
@testable import ToDo

class ToDoItemStoreMock: ToDoItemStoreProtocol {
    var itemPublisher = CurrentValueSubject<[ToDoItem], Never>([])
    var checkLastCallArgument: ToDoItem?
    func check(_ item: ToDoItem) {
        checkLastCallArgument = item
    }
}
