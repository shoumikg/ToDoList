//
//  ToDoItemStoreTests.swift
//  ToDoTests
//
//  Created by Shoumik on 05/05/24.
//

import XCTest
@testable import ToDo
import Combine

final class ToDoItemStoreTests: XCTestCase {
    
    var sut: ToDoItemStore!
    
    override func setUpWithError() throws {
        sut = ToDoItemStore()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        let dummyUrl = FileManager.default.documentsURL(name: "dummy_store")
        try? FileManager.default.removeItem(at: dummyUrl)
        //I had to add this code while debugging a test failure, it's not shown on the book. This happened because the order in which tests are executed isn't always predetermined I think. Need to know more about that.
        let prodUrl = FileManager.default.documentsURL(name: "todoitems")
        try? FileManager.default.removeItem(at: prodUrl)
    }
    
    func test_add_shouldPublishChange() throws {
        //arrange
        let toDoItem = ToDoItem(title: "Dummy")
        let receivedItems = try wait(for: sut.itemPublisher) {
            sut.add(toDoItem)
        }
        XCTAssertEqual(receivedItems, [toDoItem])
    }
    
    func test_check_shouldPublishChangeInDoneItems() throws {
        let toDoItem = ToDoItem(title: "Dummy")
        sut.add(toDoItem)
        sut.add(ToDoItem(title: "Dummy 2"))
        let receivedItems = try? wait(for: sut.itemPublisher, afterChange: {
            sut.check(toDoItem)
        })
        
        let doneItems = receivedItems?.filter({ $0.done })
        XCTAssertEqual(doneItems, [toDoItem])
    }
    
    func test_init_shouldLoadPreviousToDoItems() throws {
        var sut1: ToDoItemStore? = ToDoItemStore(fileName: "dummy_store")
        let publisherExpectation = expectation(description: "Wait for publisher in \(#file)")
        let toDoItem = ToDoItem(title: "Dummy Title")
        sut1?.add(toDoItem)
        sut1 = nil
        let sut2 = ToDoItemStore(fileName: "dummy_store")
        var result: [ToDoItem]?
        let token = sut2.itemPublisher.sink { items in
            result = items
            publisherExpectation.fulfill()
        }
        
        wait(for: [publisherExpectation], timeout: 1)
        token.cancel()
        XCTAssertEqual(result, [toDoItem])
    }
    
    func test_init_whenItemIsChecked_shouldLoadPreviousToDoItems() throws {
        var sut1: ToDoItemStore? =
        ToDoItemStore(fileName: "dummy_store")
        let publisherExpectation = expectation(
            description: "Wait for publisher in \(#file)"
        )
        let toDoItem = ToDoItem(title: "Dummy Title")
        sut1?.add(toDoItem)
        sut1?.check(toDoItem)
        sut1 = nil
        let sut2 = ToDoItemStore(fileName: "dummy_store")
        var result: [ToDoItem]?
        let token = sut2.itemPublisher
            .sink { value in
                result = value
                publisherExpectation.fulfill()
            }
        
        wait(for: [publisherExpectation], timeout: 1)
        token.cancel()
        XCTAssertEqual(result?.first?.done, true)
    }
}

extension XCTestCase {
    func wait<T: Publisher>(for publisher: T, afterChange change: () -> Void, file: StaticString = #file, line: UInt = #line) throws -> T.Output where T.Failure == Never {
        let publisherExpectation = expectation(description: "Wait for publisher in \(#file)")
        var result: T.Output?
        let token = publisher
            .dropFirst()
            .sink { value in
                result = value
                publisherExpectation.fulfill()
            }
        change()
        wait(for: [publisherExpectation], timeout: 1.0)
        token.cancel()
        
        let unwrappedResult = try XCTUnwrap(result, "Publisher did not publish any value")
        return unwrappedResult
    }
}
