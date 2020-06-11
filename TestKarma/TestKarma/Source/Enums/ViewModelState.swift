//
//  ViewModelState.swift
//  TestKarma
//
//  Created by Gines Sanchez Merono on 2020-06-11.
//  Copyright © 2020 Ginés Sanchez. All rights reserved.
//

import Foundation

public enum ViewModelState<T> {
    case empty
    case initialized
    case loading
    case ready(T)
    case failure(Error)
}
