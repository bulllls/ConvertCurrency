//
//  FRC.swift
//  ConvertCurrency
//
//  Created by Ruslan Filistovich on 13/02/2020.
//  Copyright © 2020 Ruslan Filistovich. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class FRC {
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
}

