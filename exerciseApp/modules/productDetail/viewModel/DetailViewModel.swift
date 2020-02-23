//
//  DetailViewModel.swift
//  exerciseApp
//
//  Created by Егор Редько on 23.02.2020.
//  Copyright © 2020 necordu. All rights reserved.
//

import Foundation

class DetailViewModel: NSObject, DetailViewModelProtocol {
    
    let bufArray = NSMutableArray()
    
    var currencyCollection: NSMutableArray = NSMutableArray() //["USD", "GBP", "CAD", "AUD"]

    func currencyToSign(curr:String) -> String {
        
        switch curr {
        case "USD":
            return "$"
        case "GBP":
            return "£"
        case "CAD":
            return "C$"
        case "AUD":
            return "A$"
        default:
            return curr
        }
        
    }
    
    func convertTransaction(amount: String, currency: String) -> String {
        
        
        if currency == "GBP"{
            
            return currencyToSign(curr: currency) + amount
            
        }
        
        guard let amount = Double(amount) else { return "error amount type" }
        
        return "£" + self.transact(amount: amount, currency: currency)
        
    }
    
    private func transact(amount: Double, currency: String) -> String {
        
        for object in bufArray {
            
            let objectBuf = object as! Detail
            
            if (objectBuf.from! == currency && objectBuf.to! == "GBP") {
                return String(format: "%.2f", amount * Double(objectBuf.rate)!)
            
                
            } else if (objectBuf.from! == "GBP" && objectBuf.to! == currency) {
                    
                return String(format: "%.2f", amount / Double(objectBuf.rate)!)
                
            } else {
                
                continue
            }
            
        }
        
        return self.transactCurrency(currency: currency, amount: amount)
        
    }
    
    func transactCurrency(currency: String, amount: Double) -> String {
        
        var currencyBuf = currency
        var amountBuf = amount
        var i = 0
        while i < currencyCollection.count {
            for obj in bufArray {
                let objBuf = obj as! Detail
                if (currencyBuf == objBuf.from && (currencyCollection[i] as! String) == objBuf.to) {
                    amountBuf = amountBuf * Double(objBuf.rate)!
                    currencyBuf = currencyCollection[i] as! String
                    for k in 0...bufArray.count {
                        
                        if ((bufArray[k] as! Detail).from! == currencyBuf && (bufArray[k] as! Detail).to! == "GBP") {
                            return String(format: "%.2f", amountBuf * Double((bufArray[k] as! Detail).rate)!)
                        
                            
                        } else if ((bufArray[k] as! Detail).from! == "GBP" && (bufArray[k] as! Detail).to! == currencyBuf) {
                                
                            return String(format: "%.2f", amountBuf / Double((bufArray[k] as! Detail).rate)!)
                            
                        }
                        
                    }
                }
            }
            i+=1
        }
        
        return ""
        
    }
    
    
    
    func parseRates() {
        
        var propertyListFormat = PropertyListSerialization.PropertyListFormat.xml
        var plistData: NSArray = []
        let plistPath: String? = Bundle.main.path(forResource: "rates", ofType: "plist")
        let plistXML = FileManager.default.contents(atPath: plistPath!)!
        do {
            plistData = try PropertyListSerialization.propertyList(from: plistXML, options: .mutableContainersAndLeaves, format: &propertyListFormat)  as! NSArray
            
            
            for obj in plistData {
                
                let objectBuf = (obj as! NSDictionary)
                let objRes = Detail(from: objectBuf.value(forKey: "from") as! String, to: objectBuf.value(forKey: "to") as! String, rate: objectBuf.value(forKey: "rate") as! String)
                if !currencyCollection.contains(objRes.from!) {
                    currencyCollection.add(objRes.from!)
                }
                
                if !currencyCollection.contains(objRes.to!) {
                    currencyCollection.add(objRes.to!)
                }
                bufArray.add(objRes)
                
            }
        } catch {
            print("Error reading plist: \(error), format: \(propertyListFormat)")
        }
    }
    
}
