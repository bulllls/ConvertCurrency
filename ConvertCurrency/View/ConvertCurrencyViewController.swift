//
//  ViewController.swift
//  ConvertCurrency
//
//  Created by Ruslan Filistovich on 12/02/2020.
//  Copyright © 2020 Ruslan Filistovich. All rights reserved.
//

import UIKit

class ConvertCurrencyViewController: UIViewController {
    @IBOutlet weak var from: UIPickerView!
    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var result: UILabel!
    var viewModel = ConvertCurrencyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.net.fechAllCurrensyIndex()

    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    func update(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.result.text = self?.viewModel.net.value
        }
    }
    @IBAction func convert(_ sender: Any) {
        viewModel.net.currencyConverter(from: viewModel.from, to: viewModel.to, amount: amount.text ?? "1", completionHandler: update())
    }
}

extension ConvertCurrencyViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.net.currency.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return viewModel.net.currency[row].index
        default:
            return viewModel.net.currency.reversed()[row].index
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            viewModel.from = viewModel.net.currency[row].index
            print(viewModel.from)
        default:
            viewModel.to = viewModel.net.currency.reversed()[row].index
            print(viewModel.to)
        }
    }
    
}

