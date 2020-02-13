//
//  Network.swift
//  ConvertCurrency
//
//  Created by Ruslan Filistovich on 12/02/2020.
//  Copyright © 2020 Ruslan Filistovich. All rights reserved.
//

import Foundation
import Alamofire
import CoreData

class Network {
    var data = FRC()
    
    
    func fechAllCurrensyIndex() -> [Currency0]{
        var currencies = [Currency0]()
        let parametrs: Parameters = [
            "x-rapidapi-host": "currency-converter5.p.rapidapi.com",
            "x-rapidapi-key": "94d966144cmshe4f021342f75374p108d75jsnfb980c2ff046"
        ]
        Alamofire.request("https://currency-converter5.p.rapidapi.com/currency/list?format=json", method: .get, headers: parametrs as? HTTPHeaders).responseJSON {
            response in
            switch response.result {
            case .success(let value):
                guard
                    let json = value as? [String : Any],
                    let results = json["currencies"] as? [String : String]
                    else { return }
                for item in results {
                    let newTask = Currency(context: self.data.frc.managedObjectContext)
                    newTask.index = item.key
                    newTask.desc = item.value
                    try? self.data.frc.managedObjectContext.save()
                    print("======>", self.data.frc.fetchedObjects?.endIndex)
                    currencies.append(Currency0(index: item.key, fullDiscription: item.value))
                }
                print("999", currencies)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        return currencies
    }
    
    func currencyConverter(from: String = "USD", to: String = "RUB", amount: String = "1") -> String {
        var result = ""
        let parametrs: Parameters = [
            "x-rapidapi-host": "currency-converter5.p.rapidapi.com",
            "x-rapidapi-key": "94d966144cmshe4f021342f75374p108d75jsnfb980c2ff046"
        ]
        Alamofire.request("https://currency-converter5.p.rapidapi.com/currency/convert?format=json&from=\(from)&to=\(to)&amount=\(amount)", method: .get, headers: parametrs as? HTTPHeaders).responseJSON {
            response in
            switch response.result {
            case .success(let value):
                guard
                    let json = value as? [String : Any],
                    let results = json["rates"] as? [String : [String : String]],
                    let res = results[to]?["rate"]
                    else { return }
                result = res
                print("res = \(res), result = \(result)")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        return result
    }
}
