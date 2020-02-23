//
//  EProductsViewModel.swift
//  exerciseApp
//
//  Created by Егор Редько on 23.02.2020.
//  Copyright © 2020 necordu. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class EProductsViewModel: NSObject, EProductsViewModelProtocol {
    
    var products: BehaviorRelay<[EProducts]> = BehaviorRelay<[EProducts]>(value: [])
    
}
