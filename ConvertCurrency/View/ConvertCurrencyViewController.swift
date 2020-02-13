//
//  ViewController.swift
//  ConvertCurrency
//
//  Created by Ruslan Filistovich on 12/02/2020.
//  Copyright © 2020 Ruslan Filistovich. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift

class Currency1: Object {
    @objc dynamic var index = ""
    @objc dynamic var fullDiscription = ""
}

class ConvertCurrencyViewController: UIViewController {
    @IBOutlet weak var from: UIPickerView!
    @IBOutlet weak var to: UIPickerView!
    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var result: UILabel!
    var net = Network()
    var from1 = "USD"
    var to1 = "RUB"
    override func viewDidLoad() {
        super.viewDidLoad()
        from.delegate = self
        from.dataSource = self
        net.fechAllCurrensyIndex()
        
        
    }
    func update(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.result.text = self?.net.value
        }
    }
    @IBAction func convert(_ sender: Any) {
        net.currencyConverter(from: from1, to: to1, amount: amount.text ?? "1", completionHandler: update())
    }
}

extension ConvertCurrencyViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return net.currency.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return net.currency[row].index
        default:
            return net.currency.reversed()[row].index
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            from1 = net.currency[row].index
            print(from1)
        default:
            to1 = net.currency.reversed()[row].index
            print(to1)
        }
    }
    
}

