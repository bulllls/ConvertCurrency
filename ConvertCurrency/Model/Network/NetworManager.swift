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

class NetworManager {
    let baseURL = "https://currency-converter5.p.rapidapi.com/currency/"
    let parametrs: Parameters = [
        "x-rapidapi-host": "currency-converter5.p.rapidapi.com",
        "x-rapidapi-key": "94d966144cmshe4f021342f75374p108d75jsnfb980c2ff046"
    ]
    func convertСurrency(from: String?, to: String?, amount: String?, completion: @escaping (String) -> Void){
        Alamofire
            .request(baseURL + "convert?format=json&from=\(from ?? "USD")&to=\(to ?? "RUB")&amount=\(amount ?? "0")",
                method: .get,
                headers: parametrs as? HTTPHeaders)
            .responseJSON {
                response in
                switch response.result {
                case .success(let value):
                    guard
                        let json = value as? NSDictionary,
                        let results = json["rates"] as? [String : [String : String]],
                        let result = results[to ?? "RUB"]?["rate_for_amount"]
                        else { return }
                    completion(result)
                    print(result)
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
    
    func fechAllCurrensyIndex(completion: @escaping (CurrencyList) -> Void) {
        Alamofire
            .request(baseURL + "list?format=json",
                     method: .get,
                     headers: parametrs as? HTTPHeaders)
            .responseData {
                response in
                switch response.result {
                case .success(let value):
                    guard
                        let currencyList = try? JSONDecoder().decode(CurrencyList.self, from: value)
                        else { return }
                    completion(currencyList)
                    print("CurrencyList",currencyList)
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
}
