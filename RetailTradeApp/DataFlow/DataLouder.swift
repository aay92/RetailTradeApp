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
    
//    func safeData(with title: String){
//        let appDelegete = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegete.persistentContainer.viewContext
//        
//        guard let entity = NSEntityDescription.entity(forEntityName: "ProductEntity", in: context) else { return }
//        let taskObject = ProductEntity(entity: entity, insertInto: context)
////        taskObject.title = title
//        
//        do{
//            try context.save()
////            task.append(taskObject)
////            tableView.reloadData()
//            
//        } catch let error as NSError {
//            print(error.localizedDescription)
//        }
//    }
//    
//    func removeData(with title: String, forRowAt indexPath: IndexPath){
//        
//        let appDelegete = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegete.persistentContainer.viewContext
//        
//        guard let entity = NSEntityDescription.entity(forEntityName: "ProductEntity", in: context) else { return }
//        
//        let taskObject = ProductEntity(entity: entity, insertInto: context)
//        taskObject.name = title
//        
//        do{
//            try context.deletedObjects
////            array.removeAll()
//            
//        } catch let error as NSError {
//            print(error.localizedDescription)
        
    
}

 
