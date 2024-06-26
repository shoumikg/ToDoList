//
//  ToDoItemDetailsViewControllerTests.swift
//  ToDoTests
//
//  Created by Shoumik on 02/06/24.
//

import Foundation
import XCTest

@testable import ToDo

class ToDoItemDetailsViewControllerTests: XCTestCase {
    var sut: ToDoItemDetailsViewController!
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = (storyboard.instantiateViewController(withIdentifier: "ToDoItemDetailsViewController") as! ToDoItemDetailsViewController)
        sut.loadViewIfNeeded()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_view_shouldHaveTitleLabel() throws {
        let subview = try XCTUnwrap(sut.titleLabel)
        XCTAssertTrue(subview.isDescendant(of: sut.view))
    }
    
    func test_view_shouldHaveDateLabel() throws {
        let subview = try XCTUnwrap(sut.dateLabel)
        XCTAssertTrue(subview.isDescendant(of: sut.view))
    }
    
    func test_view_shouldHaveLocationLabel() throws {
        let subview = try XCTUnwrap(sut.locationLabel)
        XCTAssertTrue(subview.isDescendant(of: sut.view))
    }
    
    func test_view_shouldHaveDescriptionLabel() throws {
        let subview = try XCTUnwrap(sut.descriptionLabel)
        XCTAssertTrue(subview.isDescendant(of: sut.view))
    }
    
    func test_view_shouldHaveMapView() throws {
        let subview = try XCTUnwrap(sut.mapView)
        XCTAssertTrue(subview.isDescendant(of: sut.view))
    }
    
    func test_view_shouldHaveDoneButton() throws {
        let subview = try XCTUnwrap(sut.doneButton)
        XCTAssertTrue(subview.isDescendant(of: sut.view))
    }
    
    func test_settingToDoItem_shouldUpdateTitleLabel() {
        let title = "dummy title"
        let toDoItem = ToDoItem(title: title)
        sut.toDoItem = toDoItem
        
        XCTAssertEqual(title, sut.titleLabel.text)
    }
    
    func test_settingToDoItem_shouldUpdateMapView() {
        let latitude = 51.225556
        let longitude = 6.782778
        let toDoItem = ToDoItem(title: "dummy title", location: Location(name: "dummy location", coordinate: Coordinate(latitude: latitude, longitude: longitude)))
        
        sut.toDoItem = toDoItem
        
        let center = sut.mapView.centerCoordinate
        
        XCTAssertEqual(center.latitude, latitude, accuracy: 0.000_01)
        XCTAssertEqual(center.longitude, longitude, accuracy: 0.000_01)
    }
    
    func test_settingToDoItem_shouldUpdateButtonState() {
        var toDoItem = ToDoItem(title: "dummy title")
        toDoItem.done = true
        sut.toDoItem = toDoItem
        XCTAssertFalse(sut.doneButton.isEnabled)
    }
    
    func test_sendingButtonAction_shouldCheckItem() {
        let toDoItem = ToDoItem(title: "dummy title")
        sut.toDoItem = toDoItem
        let storeMock = ToDoItemStoreMock()
        
        sut.toDoItemStore = storeMock
        sut.doneButton.sendActions(for: .touchUpInside)
        
        XCTAssertEqual(storeMock.checkLastCallArgument, toDoItem)
    }
}
