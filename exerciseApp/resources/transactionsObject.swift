//
//  transactionsObject.swift
//  exerciseApp
//
//  Created by Егор Редько on 23.02.2020.
//  Copyright © 2020 necordu. All rights reserved.
//

import Foundation

extension transactionsObject {
    enum CodingKeys: String, CodingKey {

        case amount
        case currency
        case sku
        
    }

}

struct transactionsObject: Codable {
    
    public var amount: String
    public var currency: String
    public var sku: String
    
    init(amount: String, currency: String, sku: String) {
        self.amount = amount
        self.currency = currency
        self.sku = sku
    }
    
}

