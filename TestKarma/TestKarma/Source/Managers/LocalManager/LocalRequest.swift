//
//  LocalRequest.swift
//  TestKarma
//
//  Created by Gines Sanchez Merono on 2020-06-11.
//  Copyright © 2020 Ginés Sanchez. All rights reserved.
//

import Foundation
import CoreLocation

enum LocalRequest: APIRequest {
    case getLocals

    var schema: String {
        return "https://"
    }

    var apiHost: String {
        return "storage.googleapis.com/engineering-4b0b7d62/"
    }

    var path: String {
        return "locations_filtered.json"
    }

    var method: HTTPMethod {
        return .get
    }

    var queryParameters: [String : String]? {
        return nil
    }

    var httpHeaders: [String : String]? {
        return nil
    }

    var bodyData: Data? {
        return nil
    }

    var bodyEncoding: HTTPBodyEncoding? {
        return .json
    }
}
