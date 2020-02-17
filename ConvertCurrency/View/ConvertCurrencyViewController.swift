//
//  ViewController.swift
//  ConvertCurrency
//
//  Created by Ruslan Filistovich on 12/02/2020.
//  Copyright © 2020 Ruslan Filistovich. All rights reserved.
//

import UIKit
import ReactiveKit

class ConvertCurrencyViewController: UIViewController {
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var amountValue: UITextField!
    @IBOutlet weak var convertibleResult: UILabel!
    @IBOutlet weak var firsStackView: UIStackView!
    @IBOutlet weak var convertFrom: UILabel!
    @IBOutlet weak var convertTo: UILabel!
    @IBOutlet weak var secondStackView: UIStackView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var activityView: UIView!
    var viewModel = ConvertCurrencyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         activityView.isHidden = true
        //получаем валюту
        viewModel.getAndSaveIdCurrencies()
        //не даем клавиатуре перекрывать inputField
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height / 5
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    //прячем клавиатуру
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        amountValue.endEditing(true)
        super.touchesBegan(touches, with: event)
    }

    //конвертируем
    @IBAction func convert(_ sender: Any) {
        amountValue.endEditing(true)
        activityIndicator.startAnimating()
        activityView.isHidden = false
        viewModel.convertAmount = amountValue.text
        viewModel.getAmountConvertiblCurrency()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.convertibleResult.text = self?.viewModel.conversionResult
            self?.activityIndicator.stopAnimating()
            self?.activityView.isHidden = true
        }
    }
    //выбираем другую валюту
    @IBAction func another(_ sender: Any) {
        firsStackView.isHidden = true
        currencyPicker.reloadAllComponents()
        secondStackView.isHidden = false
        viewModel.convertFrom = viewModel.сurrenciesList().first?.index
        viewModel.convertTo = viewModel.сurrenciesList().reversed().first?.index
    }
    //возвращаемся с новой валютой
    @IBAction func back(_ sender: Any) {
        convertFrom.text = viewModel.convertFrom
        convertTo.text = viewModel.convertTo
        secondStackView.isHidden = true
        firsStackView.isHidden = false
    }
}

extension ConvertCurrencyViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.currencyDataBase.currency.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return viewModel.сurrenciesList()[row].index
        default:
            return viewModel.сurrenciesList().reversed()[row].index
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            viewModel.convertFrom = viewModel.сurrenciesList()[row].index
        default:
            viewModel.convertTo = viewModel.сurrenciesList().reversed()[row].index
        }
    }
    
}

