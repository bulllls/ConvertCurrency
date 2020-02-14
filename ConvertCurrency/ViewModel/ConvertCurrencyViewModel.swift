//
//  ConvertCurrencyViewModel.swift
//  ConvertCurrency
//
//  Created by Ruslan Filistovich on 12/02/2020.
//  Copyright © 2020 Ruslan Filistovich. All rights reserved.
//

import Foundation
import UIKit

class ConvertCurrencyViewModel {
    var networkManager = Network()
    var dataBase = DataBase()
    var from = "USD"
    var to = "RUB"
    var amount: String?
    var resultValue: String?
    lazy var currency = {
        return self.dataBase.currency
    }
    
    func getAmountConvertiblCurrency() {
        networkManager.convertСurrency(from: from, to: to, amount: amount) { [weak self] (result) in
            self?.resultValue = result
            print("RESULT", result)
        }
    }
    
    func getValueAllCurrencies() {
        dataBase.getIdAllCurrencies()
    }
}
