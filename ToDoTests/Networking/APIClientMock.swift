//
//  APIClientMock.swift
//  ToDoTests
//
//  Created by Shoumik on 09/07/24.
//

import Foundation
@testable import ToDo

class APIClientMock: APIClientProtocol {
    var coordinateAddress: String?
    var coordinateReturnValue: Coordinate?
    
    func coordinate(for address: String, completion: (Coordinate?) -> Void) {
        coordinateAddress = address
        completion(coordinateReturnValue)
    }
}
