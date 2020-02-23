//
//  DetailViewModelProtocol.swift
//  exerciseApp
//
//  Created by Егор Редько on 23.02.2020.
//  Copyright © 2020 necordu. All rights reserved.
//

import Foundation

protocol DetailViewModelProtocol {
    
    func currencyToSign(curr: String) -> String
    
    func convertTransaction(amount: String, currency: String) -> String
    
    func parseRates()

}
