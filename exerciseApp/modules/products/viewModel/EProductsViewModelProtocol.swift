//
//  EProductsViewModelProtocol.swift
//  exerciseApp
//
//  Created by Егор Редько on 23.02.2020.
//  Copyright © 2020 necordu. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol EProductsViewModelProtocol {
    
    var products: BehaviorRelay<[EProducts]> { get }
    
    func parsePlist() -> [String: Any]
    
}
