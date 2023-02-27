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
    func save() {
        
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

    func fetchProductData<T: NSManagedObject>(_ objectType: T.Type) -> [T] {
        
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do {
            
            let fetchObjects = try context.fetch(fetchRequest) as? [T]
            return fetchObjects ?? [T]()
        } catch {
            print(error)
            return[T]()
        }
    }
    
    func delete(_ object: NSManagedObject){
        context.delete(object)
        save()
    }
    
    func deleteAllData(_ entity:String) {
        
        let entityName = String(describing: entity)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                context.delete(objectData)
                print("Detele all data in \(entity)")
            }
        } catch let error {
            print("Detele all data in \(entity) error :", error)
        }
    }
    
}

 
