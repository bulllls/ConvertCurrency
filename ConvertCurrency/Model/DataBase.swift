//
//  DataBase.swift
//  ConvertCurrency
//
//  Created by Ruslan Filistovich on 14/02/2020.
//  Copyright © 2020 Ruslan Filistovich. All rights reserved.
//

import Foundation
import RealmSwift

class DataBase {
    let network = Network()
    let realm = try! Realm()
    lazy var currency: Results<Currency> = { self.realm.objects(Currency.self) }()

    
    func getIdAllCurrencies(){
        network.fechAllCurrensyIndex { [weak self] (result) in
            if self?.currency.isEmpty ?? false {
                for item in result {
                    self?.addNewObject(item: item)
                }
            }
        }
    }
    
    func addNewObject(item: (key: String, value: String)) {
        try! self.realm.write() {
            let newCyrr = Currency()
            newCyrr.index = item.key
            newCyrr.fullDiscription = item.value
            self.realm.add(newCyrr)
            print(newCyrr.index)
        }
        self.currency = self.realm.objects(Currency.self)
    }
}

