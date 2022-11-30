//
//  AllDataViewController.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 21.11.2022.
//

import UIKit
import CoreData

class AllDataViewController: BaseController {
    
    //MARK: - dataFlowFromCoreData
    var manageObjectContext: NSManagedObjectContext!
    var products = [ProductEntity]()
    
    let tableViewProducts : UITableView = {
        let table = UITableView()
        table.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        return table
    }()
}

extension AllDataViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadSaveData()
    }
    
    override func setupViews() {
        super.setupViews()
        
        manageObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
           self.loadSaveData()
        
        
//        products = managerData.fetchProductData(ProductEntity.self)
        print("Количество продуктов в массиве: \(products.count)")
        setDelegate()
        view.addViewWithoutTAMIC(tableViewProducts)

    }
    
    func loadSaveData()  {
        let eventRequest: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()
        do{
            products = try manageObjectContext.fetch(eventRequest)
            self.tableViewProducts.reloadData()
        } catch {
            print("Could not load save data: \(error.localizedDescription)")
        }
    }
    
    override func constraintViews() {
        super.constraintViews()
        NSLayoutConstraint.activate([
            tableViewProducts.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableViewProducts.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableViewProducts.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableViewProducts.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override func configureAppereance() {
        super.configureAppereance()
        view.backgroundColor = R.Color.background
        title = "Все продажи"
        navigationController?.tabBarItem.title = R.TabBar.title(for: Tabs.allData)
        var nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.white
        tableViewProducts.backgroundColor = .clear
    }
    
}


//MARK: - UITableViewDelegate and UITableViewDataSource
extension AllDataViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func setDelegate(){
        self.tableViewProducts.delegate = self
        self.tableViewProducts.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return managerData.fetchProductData(ProductEntity.self).count
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewProducts.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        cell.configure(with: products[indexPath.row])
        return cell
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        let eventArrayItem = products[indexPath.row]
//
//           if editingStyle == .delete {
//               manageObjectContext.delete(eventArrayItem)
//
//               do {
//                   try manageObjectContext.save()
//               } catch let error as NSError {
//                   print("Error While Deleting Note: \(error.userInfo)")
//               }
//           }
//           self.loadSaveData()
//    }
    
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//
//        let eventArrayItem = products[indexPath.row]
//
//        let editAction = UITableViewRowAction(style: .default, title: "Редактировать", handler: { (action, IndexPath) in
//            print("Edit tapped")
//            })
//        editAction.backgroundColor = UIColor.systemGray
//
//        let deleteAction = UITableViewRowAction(style: .default, title: "Удалить", handler: { (action, IndexPath) in
//            //print("Delete tapped")
//            self.manageObjectContext.delete(eventArrayItem)
//            do {
//                try self.manageObjectContext.save()
//
//            } catch let error as NSError {
//                print("Error While Deleting Note: \(error.userInfo)")
//            }
//            self.loadSaveData()
//
//            })
//            deleteAction.backgroundColor = UIColor.red
//        return [deleteAction, editAction]
//    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let eventArrayItem = products[indexPath.row]

        let remove = UIContextualAction(style: .destructive, title: "Удалить") { (action, view, completion) in
            
            self.manageObjectContext.delete(eventArrayItem)
                        do {
                            try self.manageObjectContext.save()
            
                        } catch let error as NSError {
                            print("Error While Deleting Note: \(error.userInfo)")
                        }
                        self.loadSaveData()
        completion(true)
        }
        let edit = UIContextualAction(style: .normal, title: "Edit") { (action, view, completion) in
            
            let detailVC = DetailVC()
            detailVC.editingRowValue(product: eventArrayItem)
            self.navigationController?.present(detailVC, animated: true)
//            self.manageObjectContext.delete(eventArrayItem)
//                        do {
//                            try self.manageObjectContext.save()
//
//                        } catch let error as NSError {
//                            print("Error While Deleting Note: \(error.userInfo)")
//                        }
//                        self.loadSaveData()
        completion(true)
        }
        self.loadSaveData()

        let config = UISwipeActionsConfiguration(actions: [remove, edit])
        config.performsFirstActionWithFullSwipe = false
   
        return config
        
    }
}


