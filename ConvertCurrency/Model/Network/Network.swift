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
    let parametrs: Parameters = [
        "x-rapidapi-host": "currency-converter5.p.rapidapi.com",
        "x-rapidapi-key": "94d966144cmshe4f021342f75374p108d75jsnfb980c2ff046"
    ]
    func convertСurrency(from: String, to: String, amount: String?, completion: @escaping (String) -> Void){
           Alamofire
               .request("https://currency-converter5.p.rapidapi.com/currency/convert?format=json&from=\(from)&to=\(to)&amount=\(amount ?? "0")",
                   method: .get,
                   headers: parametrs as? HTTPHeaders)
               .responseJSON {
                   response in
                   switch response.result {
                   case .success(let value):
                       guard
                           let json = value as? NSDictionary,
                           let results = json["rates"] as? [String : [String : String]],
                           let result = results[to]?["rate_for_amount"]
                           else { return }
                       completion(result)
                       print(result)
                   case .failure(let error):
                       print(error.localizedDescription)
                   }
           }
       }
    
    func fechAllCurrensyIndex(completion: @escaping ([String : String]) -> Void) {
        Alamofire
            .request("https://currency-converter5.p.rapidapi.com/currency/list?format=json",
                     method: .get,
                     headers: parametrs as? HTTPHeaders)
            .responseJSON {
                response in
                switch response.result {
                case .success(let value):
                    guard
                        let json = value as? NSDictionary,
                        let results = json["currencies"] as? [String : String]
                        else { return }
                    print(results)
                    completion(results)
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
}
