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
    var networkManager = NetworManager()
    var currencyDataBase = DataBase()
    var convertFrom: String?
    var convertTo: String?
    var convertAmount: String?
    var conversionResult: String?
    lazy var сurrenciesList = {
        return self.currencyDataBase.currency
    }
    
    func getAndSaveIdCurrencies(){
        networkManager.fechAllCurrensyIndex { [weak self] (result) in
            if self?.currencyDataBase.currency.isEmpty ?? false {
                for item in result {
                    self?.currencyDataBase.addNewObject(item: item)
                }
            }
        }
    }
    
    func getAmountConvertiblCurrency() {
        networkManager.convertСurrency(from: convertFrom, to: convertTo, amount: convertAmount) { [weak self] (result) in
            self?.conversionResult = result
            print("RESULT", result)
        }
    }
    
}
