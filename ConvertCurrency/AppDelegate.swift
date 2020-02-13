//
//  AppDelegate.swift
//  ConvertCurrency
//
//  Created by Ruslan Filistovich on 12/02/2020.
//  Copyright © 2020 Ruslan Filistovich. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "ConvertCurrency")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}



//Добрый день всем. Еще раз поздравляю с успешным окончанием основной части курса. Что касается итогового проекта (еще раз обращаю ваше внимание на то, что это не обязательное к выполнению задание - если у вас есть своя идея для итогового проекта, вы можете согласовать ее со мной и выполнять собственный проект). Возможно гитхаб апи будет слишком сложным, поэтому мы возьмем чуть более легкий вариант.
//
//Есть следующее API https://rapidapi.com/warting/api/currency-converter
//Это конвертер валют, в нем есть два метода:
//1. получить список всех доступных валют
//2. Конвертировать сумму из одной валюты, в другую.
//
//Ваша задача зарегистрироваться на сайте и получить ключи доступа для апи. Затем вам необходимо будет разработать приложение для конвертации валют. Как именно будет реализован принцип - решать вам. Вы можете сначала попросить пользователя выбрать исходную валюту, затем целевую, затем ввести сумму. Можете делать все на одном экране. Все ограничивается исключительно вашей фантазией и пониманием UX.
//Обязательным условием является создание локальной БД (CoreData/Realm - на ваш выбор) в которую необходимо будет записать все доступные валюты для конвертации. Таким образом даже если пользователь оффлайн, список валют был бы ему всегда доступен.
//(По желанию можно сделать функционал для обновления локального списка, хотя мы понимаем что вряд ли он будет часто меняться).
//Конвертация осуществляется путем вызова метода, и дальнейшем отображении полученного от API результата пользователю.
//
//Для уверенных в своих силах можно сделать историю операций и сохранять локально, чтобы пользователь мог затем просмотреть ее - будет очень красиво. (Так же можно предоставить возможность удаления операции из истории).
//
//Так же можно сделать функционал для повторения операции из истории (то есть пользователь делал конвертацию месяц назад, и может повторить операцию сейчас и проверить какой курс сейчас)
//
//
//
//Любые пожелания приветствуются. Если у вас есть еще какие-либо идеи по проекту - не бойтесь пробовать их реализовать. В случае если что-то непонятно - спрашивайте.
