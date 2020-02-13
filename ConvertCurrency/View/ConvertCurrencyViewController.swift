//
//  ViewController.swift
//  ConvertCurrency
//
//  Created by Ruslan Filistovich on 12/02/2020.
//  Copyright © 2020 Ruslan Filistovich. All rights reserved.
//

import UIKit
import Alamofire
import CoreData

struct Currency0 {
    var index: String
    var fullDiscription: String
}

class ConvertCurrencyViewController: UIViewController {
    @IBOutlet weak var from: UIPickerView!
    @IBOutlet weak var to: UIPickerView!
    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var result: UILabel!
    var curr = [Currency0]()
    var test = ["1", "2", "3","4", "5", "6","7", "8", "9","10", "11", "12","13"]
    var net = Network()
    
    lazy var frc: NSFetchedResultsController<Currency> = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<Currency>(entityName: "Currency")
        //сортировка
        let descriptor = NSSortDescriptor(key: "index", ascending: true)
        request.sortDescriptors = [descriptor]
        let controller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        return controller
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
       
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        curr = net.fechAllCurrensyIndex()
        
        from.delegate = self
        from.dataSource = self
        
        
        
    }


    @IBAction func convert(_ sender: Any) {
        result.text = net.currencyConverter()
    }
}

extension ConvertCurrencyViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return test.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return test[row]
    }
    
    
}

//Слежу за изменениями и обновляю базу данных
extension ConvertCurrencyViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        from.reloadAllComponents()
        //todoTableview.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
//        switch type {
//        case .insert:
//            todoTableview.insertRows(at: [indexPath ?? newIndexPath ?? IndexPath(row: 0, section: 0)], with: .fade)
//        case .delete:
//            todoTableview.deleteRows(at: [indexPath!], with: .fade)
//        case .move:
//            todoTableview.moveRow(at: indexPath!, to: newIndexPath!)
//        case .update:
//            todoTableview.reloadRows(at: [indexPath!], with: .fade)
//        @unknown default:
//            fatalError()
//        }
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        //todoTableview.endUpdates()
    }
    
    //сохраняю в базу
    func saveNewTask(index: String, desc: String) {
        let newTask = Currency(context: frc.managedObjectContext)
        newTask.index = index
        newTask.desc = desc
        try? frc.managedObjectContext.save()
    }
    
}
