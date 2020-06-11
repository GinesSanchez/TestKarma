//
//  MockNetworkManager.swift
//  TestKarmaTests
//
//  Created by Gines Sanchez Merono on 2020-06-11.
//  Copyright © 2020 Ginés Sanchez. All rights reserved.
//

import Foundation
@testable import TestKarma

final class MockNetworkManager: NetworkManagerType {
    
    var customData: Data? = nil
    var customResponse: URLResponse? = nil
    var customError: Error? = nil

    func execute(urlRequest: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        completion(customData, customResponse, customError)
    }
}
