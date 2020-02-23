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
    
    func parsePlist() -> [String: Any] {
        
        var propertyListFormat = PropertyListSerialization.PropertyListFormat.xml
        var plistData: NSArray = []
        let plistPath: String? = Bundle.main.path(forResource: "transactions", ofType: "plist")
        let plistXML = FileManager.default.contents(atPath: plistPath!)!
        do {
            plistData = try PropertyListSerialization.propertyList(from: plistXML, options: .mutableContainersAndLeaves, format: &propertyListFormat)  as! NSArray
            let resultsObj = NSMutableArray()
            for obj in plistData {
                
                let objectBuf = (obj as! NSDictionary)
                let objRes = transactionsObject(amount: objectBuf.value(forKey: "amount") as! String, currency: objectBuf.value(forKey: "currency") as! String, sku: objectBuf.value(forKey: "sku") as! String)
                resultsObj.add(objRes)
                
            }
            var fillDictionary: [String:Any] = [:] as! [String : Any]
            for obj in resultsObj {
                
                let objBuf = (obj as! transactionsObject)
                if (fillDictionary[objBuf.sku] == nil) {
                    
                   let arr = NSMutableArray()
                   arr.add(objBuf)
                   var bufDict: [String: Any] = [:]
                   bufDict["arr"] = arr as! [transactionsObject]
                   bufDict["count"] = 1
                   fillDictionary[objBuf.sku] = bufDict
                    
                } else {
                    
                    var arr = (fillDictionary[objBuf.sku] as! [String: Any])["arr"] as! [transactionsObject]
                    arr.append(objBuf)
                    var bufDict: [String: Any] = [:]
                    bufDict["arr"] = arr
                    bufDict["count"] = arr.count
                    fillDictionary[objBuf.sku] = bufDict
                    
                }
                
            }
            return fillDictionary
        } catch {
            print("Error reading plist: \(error), format: \(propertyListFormat)")
            return [:]
        }
        
        
    }
    
}
