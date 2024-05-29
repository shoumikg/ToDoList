//
//  ToDoItemCellTests.swift
//  ToDoTests
//
//  Created by Shoumik on 07/05/24.
//

import XCTest
@testable import ToDo

final class ToDoItemCellTests: XCTestCase {
    
    var sut: ToDoItemCell!

    override func setUpWithError() throws {
        sut = ToDoItemCell()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_hasTitleLabelSubview() {
        let subview = sut.titleLabel
        XCTAssert(subview.isDescendant(of: sut.contentView))
    }
    
    func test_hasDateLabelSubview() {
        let subview = sut.dateLabel
        XCTAssert(subview.isDescendant(of: sut.contentView))
    }
    
    func test_hasLocationLabelSubview() {
        let subview = sut.locationLabel
        XCTAssertTrue(subview.isDescendant(of: sut.contentView))
    }
}
