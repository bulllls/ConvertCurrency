//
//  Currency.swift
//  ConvertCurrency
//
//  Created by Ruslan Filistovich on 13/02/2020.
//  Copyright © 2020 Ruslan Filistovich. All rights reserved.
//

import Foundation
import RealmSwift

class Currency: Object {
    @objc dynamic var index = ""
    @objc dynamic var fullDescription = ""
}

struct CurrencyList: Codable {
    let currencies: [String: String]
    let status: String
}

// MARK: - RateInfo
struct RateInfo: Codable {
    let amount, baseCurrencyCode, baseCurrencyName: String
    let rates: [String:[String: String]]
    let status, updatedDate: String
    
    enum CodingKeys: String, CodingKey {
        case amount
        case baseCurrencyCode = "base_currency_code"
        case baseCurrencyName = "base_currency_name"
        case rates, status
        case updatedDate = "updated_date"
    }
}
