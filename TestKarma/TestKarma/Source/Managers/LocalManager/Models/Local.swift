//
//  Local.swift
//  TestKarma
//
//  Created by Gines Sanchez Merono on 2020-06-11.
//  Copyright © 2020 Ginés Sanchez. All rights reserved.
//

import Foundation
import CoreLocation

struct Local: Codable {
    let id: Int
    let name: String
    let latitude: Double
    let longitude: Double
    let following: Bool
    let description: String
    let phone: String
    let website: String
}

extension Local {
    var location: CLLocation {
        return CLLocation(latitude: latitude, longitude: longitude)
    }

    var coordinate: CLLocationCoordinate2D {
        return location.coordinate
    }
}
