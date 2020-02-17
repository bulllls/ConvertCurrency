//
//  ConvertCurrencyViewModel.swift
//  ConvertCurrency
//
//  Created by Ruslan Filistovich on 12/02/2020.
//  Copyright © 2020 Ruslan Filistovich. All rights reserved.
//

import Foundation
import UIKit
import ReactiveKit
import Bond

class ConvertCurrencyViewModel {
    private let disposeBag = DisposeBag()
    let conversionResult = Observable<String>("0.0")
    
    var networkManager = NetworManager()
    var currencyDataBase = DataBase()
    
    lazy var сurrenciesList = {
        return self.currencyDataBase.currency
    }
    
    func getAndSaveIdCurrencies(){
        networkManager.fechAllCurrensyIndex { [weak self] (result) in
            if self?.currencyDataBase.currency.isEmpty ?? false {
                for item in result.currencies {
                    self?.currencyDataBase.addNewObject(item: item)
                }
            }
        }
    }
    
    func getAmountConvertiblCurrency(from: String?, to: String?, amount: String?) {
        networkManager.convertСurrency(from: from, to: to, amount: amount) { [weak self] (result) in
            self?.conversionResult.value = result
            print("RESULT", result)
        }
    }
    
}
