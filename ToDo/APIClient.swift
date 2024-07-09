//
//  APIClient.swift
//  ToDo
//
//  Created by Shoumik on 09/07/24.
//

import Foundation

protocol APIClientProtocol {
    func coordinate(for: String, completion: (Coordinate?) -> Void)
}

class APIClient: APIClientProtocol {
    func coordinate(
        for: String,
        completion: (Coordinate?) -> Void) {
        }
}
