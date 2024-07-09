//
//  APIClient.swift
//  ToDo
//
//  Created by Shoumik on 09/07/24.
//

import Foundation
import CoreLocation

protocol APIClientProtocol {
    func coordinate(for: String,
                    completion: @escaping (Coordinate?) -> Void)
}

protocol GeoCoderProtocol {
    func geocodeAddressString(
        _ addressString: String,
        completionHandler:
        @escaping CLGeocodeCompletionHandler)
}

class APIClient: APIClientProtocol {
    lazy var geoCoder: GeoCoderProtocol = CLGeocoder()
    
    func coordinate(
        for address: String,
        completion: @escaping (Coordinate?) -> Void) {
            geoCoder.geocodeAddressString(address) {
                placemarks, error in
                guard let clCoordinate =
                        placemarks?.first?.location?.coordinate
                else {
                    completion(nil)
                    return
                }
                let coordinate = Coordinate(
                    latitude: clCoordinate.latitude,
                    longitude: clCoordinate.longitude)
                completion(coordinate)
            }
        }
}

extension CLGeocoder: GeoCoderProtocol {}
