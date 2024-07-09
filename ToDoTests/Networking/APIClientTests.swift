//
//  APIClientTests.swift
//  ToDoTests
//
//  Created by Shoumik on 09/07/24.
//

import XCTest
@testable import ToDo
import Intents
import Contacts

final class APIClientTests: XCTestCase {
    
    var sut: APIClient!

    override func setUpWithError() throws {
        sut = APIClient()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_coordinate_fetchesCoordinate() {
        let geoCoderMock = GeoCoderProtocolMock()
        sut.geoCoder = geoCoderMock
        let location = CLLocation(latitude: 1,
                                  longitude: 2)
        let placemark = CLPlacemark(location: location,
                                    name: nil,
                                    postalAddress: nil)
        let expectedAddress = "dummy address"
        var result: Coordinate?
        sut.coordinate(for: expectedAddress) { coordinate in
            result = coordinate
        }
        geoCoderMock.completionHandler?([placemark], nil)
        XCTAssertEqual(result?.latitude,
                       location.coordinate.latitude)
        XCTAssertEqual(result?.longitude,
                       location.coordinate.longitude)
    }
    
    func test_coordinate_shouldCallGeoCoderWithAddress() {
        let geoCoderMock = GeoCoderProtocolMock()
        sut.geoCoder = geoCoderMock
        let expectedAddress = "dummy address"
        sut.coordinate(for: expectedAddress) { _ in
        }
        XCTAssertEqual(geoCoderMock.geocodeAddressString,
                       expectedAddress)
    }
    
}
