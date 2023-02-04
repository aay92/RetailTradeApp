//
//  AllMonthViewController.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 27.01.2023.
//

import UIKit
import CoreData

class AllMonthViewController: BaseController {
    
    //MARK: - dataFlowFromCoreData
    var manageObjectContext: NSManagedObjectContext!
    var products = [ProductEntity]()
    
    
//    var manageObjectContext: NSManagedObjectContext!
//    var month = [ModelOverview]()

    let tableViewProducts : UITableView = {
        let table = UITableView()
        table.register(MonthTableViewCell.self, forCellReuseIdentifier: MonthTableViewCell.identifier)
        return table
    }()
}


extension AllMonthViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        manageObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
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
        
//        let eventRequest: NSFetchRequest<ModelOverview> = ModelOverview.fetchRequest()
//        do {
//            month = try manageObjectContext.fetch(eventRequest)
//            self.tableViewProducts.reloadData()
//        } catch {
//            print("Could not load save data: \(error.localizedDescription)")
//
//        }
        
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
        title = "Общий доход по месяцам"
        tableViewProducts.backgroundColor = R.Color.background
        view.backgroundColor = R.Color.background
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.white
    }
    
}


//MARK: - UITableViewDelegate and UITableViewDataSource
extension AllMonthViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func setDelegate(){
        self.tableViewProducts.delegate = self
        self.tableViewProducts.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        return managerData.fetchProductData(ProductEntity.self).count
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewProducts.dequeueReusableCell(withIdentifier: MonthTableViewCell.identifier, for: indexPath) as! MonthTableViewCell
      
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Нажали на ячейку")
    }
    
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
        let edit = UIContextualAction(style: .normal, title: "Редактировать") { (action, view, completion) in
            let detailVC = DetailVC()
            detailVC.editingRowValue(product: eventArrayItem)
            self.navigationController?.present(detailVC, animated: true)
            completion(true)
        }
        edit.backgroundColor = R.Color.active.withAlphaComponent(0.4)
        self.loadSaveData()
        
        let config = UISwipeActionsConfiguration(actions: [remove, edit])
        config.performsFirstActionWithFullSwipe = false
        
        return config
        
    }
}


