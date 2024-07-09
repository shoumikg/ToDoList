//
//  FileManagerExtension.swift
//  ToDo
//
//  Created by Shoumik on 06/05/24.
//

import Foundation

extension FileManager {
    func documentsURL(name: String) -> URL {
        guard let documentsURL = urls(for:.documentDirectory,
                                      in: .userDomainMask).first else {
            fatalError()
        }
        return documentsURL.appendingPathComponent(name)
    }
}
