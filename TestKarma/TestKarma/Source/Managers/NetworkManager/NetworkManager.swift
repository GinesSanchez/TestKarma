//
//  NetworkManager.swift
//  TestKarma
//
//  Created by Gines Sanchez Merono on 2020-06-11.
//  Copyright © 2020 Ginés Sanchez. All rights reserved.
//

import Foundation

protocol NetworkManagerType {
    func execute(urlRequest: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}

final class NetworkManager: NetworkManagerType {
    func execute(urlRequest: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: urlRequest, completionHandler: completion).resume()
    }
}
