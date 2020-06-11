//
//  LocalService.swift
//  TestKarma
//
//  Created by Gines Sanchez Merono on 2020-06-11.
//  Copyright © 2020 Ginés Sanchez. All rights reserved.
//

import Foundation

enum LocalManagerError: Error {
    case wrongRequestUrl
    case responseError
    case noResponseData
    case invalidJson
    case unknown
}

protocol LocalManagerType {
    var networkManager: NetworkManagerType { get }
    init(networkManager: NetworkManagerType)
    func getLocals(completion: @escaping (Result<[Local], LocalManagerError>) -> Void)
}

final class LocalManager: LocalManagerType {
    var networkManager: NetworkManagerType

    init(networkManager: NetworkManagerType) {
        self.networkManager = networkManager
        return
    }

    func getLocals(completion: @escaping (Result<[Local], LocalManagerError>) -> Void) {
        guard let urlRequest = LocalRequest.getLocals.urlRequest else {
            return completion(.failure(.wrongRequestUrl))
        }
        networkManager.execute(urlRequest: urlRequest) { (data, response, error) in
            guard error == nil else {
                return completion(.failure(.responseError))
            }

            guard let data = data else {
                return completion(.failure(.noResponseData))
            }

            //We don't have status code to check

            do {
                let localsArray = try JSONDecoder().decode([Local].self, from: data)
                completion(.success(localsArray))
            } catch {
                return completion(.failure(.invalidJson))
            }
        }
    }
}
