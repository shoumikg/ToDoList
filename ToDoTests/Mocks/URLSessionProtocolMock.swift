//
//  URLSessionProtocolMock.swift
//  ToDoTests
//
//  Created by Shoumik on 09/07/24.
//

import Foundation
@testable import ToDo

class URLSessionProtocolMock: URLSessionProtocol {
    var dataForDelegateReturnValue: (Data, URLResponse)?
    var dataForDelegateRequest: URLRequest?
    var dataForDelegateError: Error?
    
    func data(for request: URLRequest,
              delegate: URLSessionTaskDelegate?)
    async throws -> (Data, URLResponse) {
        if let error = dataForDelegateError {
            throw error
        }
        dataForDelegateRequest = request
        guard let dataForDelegateReturnValue =
                dataForDelegateReturnValue else {
            fatalError()
        }
        return dataForDelegateReturnValue
    }
}
