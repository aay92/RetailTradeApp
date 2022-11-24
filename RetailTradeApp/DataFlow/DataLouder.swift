//
//  DataLouder.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 24.11.2022.
//

import UIKit
import CoreData

final class DataLouder {
//    Create singlton
    static let shared = DataLouder()
    private init(){}
    
//    func safeData(){}
//    func getData(){}
//    func removeData(){}
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
   
        let container = NSPersistentContainer(name: "ProductModelCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context = persistentContainer.viewContext

    // MARK: - Core Data Saving support

    func save () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("Удачно сохранились")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

 
