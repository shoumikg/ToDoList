//
//  LocationTests.swift
//  ToDoTests
//
//  Created by Shoumik on 05/05/24.
//

import XCTest
@testable import ToDo

final class LocationTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_init_setsCoordinate() throws {
        let coordinate = Coordinate(latitude: 1, longitude: 2)
        let location = Location(name: "Dummy", coordinate: coordinate)
        
        let resultCoordinate = try XCTUnwrap(location.coordinate)
        
        XCTAssertEqual(location.coordinate?.latitude, coordinate.latitude)
        XCTAssertEqual(location.coordinate?.longitude, coordinate.longitude)
    }
    
    
}
