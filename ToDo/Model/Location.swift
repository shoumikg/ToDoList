//
//  Location.swift
//  ToDo
//
//  Created by Shoumik on 05/05/24.
//

import Foundation

struct Location: Equatable, Codable {
    let name: String
    let coordinate: Coordinate?
    
    init(name: String, 
         coordinate: Coordinate? = nil) {
        self.name = name
        self.coordinate = coordinate
    }
}
