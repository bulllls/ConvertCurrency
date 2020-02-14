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
    @IBOutlet weak var firsStackView: UIStackView!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var secondStackView: UIStackView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var activityView: UIView!
    var viewModel = ConvertCurrencyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         activityView.isHidden = true
        //получаем валюту
        viewModel.net.fechAllCurrensyIndex()
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
        amount.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    //обновляем результат
    func update(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.result.text = self?.viewModel.net.value
            self?.activity.stopAnimating()
            self?.activityView.isHidden = true
        }
    }
    //конвертируем
    @IBAction func convert(_ sender: Any) {
        amount.endEditing(true)
        activity.startAnimating()
        activityView.isHidden = false
        viewModel.net.currencyConverter(from: viewModel.from, to: viewModel.to, amount: amount.text ?? "1", completionHandler: update())
    }
    //выбираем другую валюту
    @IBAction func another(_ sender: Any) {
        firsStackView.isHidden = true
        from.reloadAllComponents()
        secondStackView.isHidden = false
    }
    //возвращаемся с новой валютой
    @IBAction func back(_ sender: Any) {
        fromLabel.text = viewModel.from
        toLabel.text = viewModel.to
        secondStackView.isHidden = true
        firsStackView.isHidden = false
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

