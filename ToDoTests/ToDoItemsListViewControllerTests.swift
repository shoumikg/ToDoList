//
//  ToDoItemsListViewControllerTests.swift
//  ToDoTests
//
//  Created by Shoumik on 07/05/24.
//

import XCTest
@testable import ToDo

final class ToDoItemsListViewControllerTests: XCTestCase {
    
    var sut: ToDoItemsListViewController!
    var toDoItemStoreMock: ToDoItemStoreMock!

    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = try XCTUnwrap(storyboard.instantiateInitialViewController() as? ToDoItemsListViewController)
        toDoItemStoreMock = ToDoItemStoreMock()
        sut.toDoItemStore = toDoItemStoreMock
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_shouldBeSetup() {
        XCTAssertNotNil(sut)
    }
    
    func test_shouldHaveTableView() {
        XCTAssertTrue(sut.tableView.isDescendant(of: sut.view))
    }
    
    func test_numberOfRows_whenOneItemIsSent_shouldReturnOne() {
        toDoItemStoreMock.itemPublisher.send([ToDoItem(title: "dummy 1")])
        let result = sut.tableView.numberOfRows(inSection: 0)
        
        XCTAssertEqual(result, 1)
    }
    
    func test_numberOfRows_whenTwoItemsAreSent_shouldReturnTwo() {
        toDoItemStoreMock.itemPublisher.send([ToDoItem(title: "dummy 1"), ToDoItem(title: "Dummy 2")])
        let result = sut.tableView.numberOfRows(inSection: 0)
        
        XCTAssertEqual(result, 2)
    }
    
    func test_cellForRowAt_shouldReturnCellWithTitle1() throws {
        let titleUnderTest = "dummy 1"
        toDoItemStoreMock.itemPublisher.send([ToDoItem(title: titleUnderTest)])
        let tableView = try XCTUnwrap(sut.tableView)
        
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = try XCTUnwrap(tableView.dataSource?.tableView(tableView, cellForRowAt: indexPath) as? ToDoItemCell)
        
        XCTAssertEqual(cell.titleLabel.text, titleUnderTest)
    }
    
    func test_cellForRowAt_shouldReturnCellWithTitle2() throws {
        let titleUnderTest = "dummy 2"
        toDoItemStoreMock.itemPublisher.send([ToDoItem(title: "dummy 1"),
                                              ToDoItem(title: titleUnderTest)])
        let tableView = try XCTUnwrap(sut.tableView)
        
        let indexPath = IndexPath(row: 1, section: 0)
        let cell = try XCTUnwrap(tableView.dataSource?.tableView(tableView, cellForRowAt: indexPath) as? ToDoItemCell)
        
        XCTAssertEqual(cell.titleLabel.text, titleUnderTest)
    }
    
    func test_cellForRowAt_shouldReturnCellWithDate() throws {
        let date = Date()
        toDoItemStoreMock.itemPublisher.send([ToDoItem(title: "dummy 1", timestamp: date.timeIntervalSince1970)])
        let tableView = try XCTUnwrap(sut.tableView)
        let indexPath  = IndexPath(row: 0, section: 0)
        let cell = try XCTUnwrap(tableView.dataSource?.tableView(tableView, cellForRowAt: indexPath) as? ToDoItemCell)
        
        XCTAssertEqual(cell.dateLabel.text, sut.dateFormatter.string(from: date))
    }
}
