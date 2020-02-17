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

//
//struct Currency1: Codable {
//    var id: String
//    var descr: String
//}
//struct CurrencyList: Codable {
//    let currencies: [Currency1]
//}
//
// MARK: - Currency


// MARK: - Currencies
//struct Currencies: Codable {
//    let aud, bgn, brl, cad: String
//    let chf, cny, czk, dkk: String
//    let eur, gbp, hkd, hrk: String
//    let huf, idr, ils, inr: String
//    let isk, jpy, krw, mxn: String
//    let myr, nok, nzd, php: String
//    let pln, ron, rub, sek: String
//    let sgd, thb, currenciesTRY, usd: String
//    let zar: String
//
//    enum CodingKeys: String, CodingKey {
//        case aud = "AUD"
//        case bgn = "BGN"
//        case brl = "BRL"
//        case cad = "CAD"
//        case chf = "CHF"
//        case cny = "CNY"
//        case czk = "CZK"
//        case dkk = "DKK"
//        case eur = "EUR"
//        case gbp = "GBP"
//        case hkd = "HKD"
//        case hrk = "HRK"
//        case huf = "HUF"
//        case idr = "IDR"
//        case ils = "ILS"
//        case inr = "INR"
//        case isk = "ISK"
//        case jpy = "JPY"
//        case krw = "KRW"
//        case mxn = "MXN"
//        case myr = "MYR"
//        case nok = "NOK"
//        case nzd = "NZD"
//        case php = "PHP"
//        case pln = "PLN"
//        case ron = "RON"
//        case rub = "RUB"
//        case sek = "SEK"
//        case sgd = "SGD"
//        case thb = "THB"
//        case currenciesTRY = "TRY"
//        case usd = "USD"
//        case zar = "ZAR"
//    }
//}



//struct Customer: Codable, Any {
//
//    let metadata: [String: Any]
//    enum CustomerKeys: String, CodingKey {
//        case  metadata
//    }
//    init (from decoder: Decoder) throws {
//        let container =  try decoder.container (keyedBy: CustomerKeys.self)
//        metadata = try container.decode ([String: Any].self, forKey: .metadata)
//
//    }
//    func encode (to encoder: Encoder) throws {
//        var container = encoder.container (keyedBy: CustomerKeys.self)
//        try container.encode (metadata, forKey: .metadata)
//    }
//}

