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
    let realm = try! Realm()
    lazy var currency: Results<Currency> = { self.realm.objects(Currency.self) }()
    
    func addNewObject(item: (key: String, value: String)) {
        try! self.realm.write() {
            let newCyrrency = Currency()
            newCyrrency.index = item.key
            newCyrrency.fullDescription = item.value
            self.realm.add(newCyrrency)
            print(newCyrrency.index)
        }
        self.currency = self.realm.objects(Currency.self)
    }
}

