//
//  Network.swift
//  ConvertCurrency
//
//  Created by Ruslan Filistovich on 12/02/2020.
//  Copyright © 2020 Ruslan Filistovich. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

class Network {
    let realm = try! Realm()
    lazy var currency: Results<Currency1> = { self.realm.objects(Currency1.self) }()
    var value: String?
    func fechAllCurrensyIndex(){
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
                    if self.currency.count == 0 {
                         for item in results {
                        try! self.realm.write() {
                            let newCyrr = Currency1()
                            newCyrr.index = item.key
                            newCyrr.fullDiscription = item.value
                            self.realm.add(newCyrr)
                            print(newCyrr.index)
                        }
                        self.currency = self.realm.objects(Currency1.self)
                    }
                }
                print("currency", self.currency)
            case .failure(let error):
                self.value = "No Connect"
                print(error.localizedDescription)
            }
        }
    }
    
    func currencyConverter(from: String, to: String, amount: String, completionHandler: ()) {
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
                    let res = results[to]?["rate_for_amount"]
                    else { return }
                self.value = res
               // print(self.value)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
