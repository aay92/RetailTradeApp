//
//  AllDataViewController.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 21.11.2022.
//

import UIKit
import CoreData

class AllDataViewController: BaseController {
    
    let sectionHeaderTitles: [ProfitModelItem] = []
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animationTableViewCell()
    }
    
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
        let nav = self.navigationController?.navigationBar
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
        return 90
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
   
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = DetailAllDataViewController()
        vc.configure(name: products[indexPath.row].name ?? "",
                     imageItem: products[indexPath.row].image,
                     costPositionPrf: Int(products[indexPath.row].priceProfit),
                     costPriceGrs: Int(products[indexPath.row].priceGross),
                     total: Int(products[indexPath.row].priceGross) - Int(products[indexPath.row].priceProfit))
        present(vc, animated: true)
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

//MARK: - animationTableViewCell
private extension AllDataViewController {
    func animationTableViewCell(){
        let cells = self.tableViewProducts.visibleCells
        let tableViewWidth = self.tableViewProducts.bounds.width
        var indexCell: Double = 0
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: tableViewWidth / 0.85, y: 0)

            UIView.animate(withDuration: 1.7 ,
                           delay: 0.05 * indexCell,
                           usingSpringWithDamping: 0.6,
                           initialSpringVelocity: 0.3,
                           options: .curveEaseInOut) {
                cell.transform = CGAffineTransform(translationX: tableViewWidth, y: 0)

                cell.transform = CGAffineTransform.identity
            }
            indexCell += 1
        }
    }
}


