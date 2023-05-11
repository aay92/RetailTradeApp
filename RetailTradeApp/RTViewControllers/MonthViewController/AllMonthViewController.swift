//
//  AllMonthViewController.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 27.01.2023.
//

import UIKit
import CoreData
import Lottie

class AllMonthViewController: BaseController {
    
    //MARK: - dataFlowFromCoreData
//    var manageObjectContext: NSManagedObjectContext!
//    var products = [ProductEntity]()

    private let animationArrowBack = LottieAnimationView(name: "arrowBack")
     var arrowIsHidden = false
    
    var manageObjectContext: NSManagedObjectContext!
    var month = [ModelOverview]()

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
        animationArrowBackAction()

    }
    
    override func setupViews() {
        super.setupViews()
        
        manageObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        loadSaveData()
        
        //        products = managerData.fetchProductData(ProductEntity.self)
        print("Количество продуктов в массиве: \(month.count)")
        setDelegate()
        
        view.addViewWithoutTAMIC(tableViewProducts)
        view.addViewWithoutTAMIC(animationArrowBack)
        animationArrowBack.isHidden = true
        animationArrowBack.transform = animationArrowBack.transform.rotated(by: .pi / 2)
    }
    
    func loadSaveData() {
        
        let eventRequest: NSFetchRequest<ModelOverview> = ModelOverview.fetchRequest()
        do {
            month = try manageObjectContext.fetch(eventRequest)
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
            tableViewProducts.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            animationArrowBack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationArrowBack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            animationArrowBack.heightAnchor.constraint(equalToConstant: 350)
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
        return month.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewProducts.dequeueReusableCell(withIdentifier: MonthTableViewCell.identifier, for: indexPath) as! MonthTableViewCell
        let mouths = month[indexPath.row]
        cell.configure(with: mouths)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Нажали на ячейку")
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let eventArrayItem = month[indexPath.row]
        
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
            //            let detailVC = DetailVC()
            //            detailVC.editingRowValue(product: eventArrayItem)
            //            self.navigationController?.present(detailVC, animated: true)
            completion(true)
        }
        edit.backgroundColor = R.Color.active.withAlphaComponent(0.4)
        self.loadSaveData()
        
        let config = UISwipeActionsConfiguration(actions: [remove, edit])
        config.performsFirstActionWithFullSwipe = false
        
        return config
        
    }
}
//MARK: - animationArrowBackAction
extension AllMonthViewController {
    ///animationArrowBackAction - Выводит анимацию, когда сохранили месяц и перешли на страницу с месецами
    func animationArrowBackAction(){
        if arrowIsHidden {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                self.animationArrowBack.isHidden = false
                self.animationArrowBack.loopMode = .loop
                self.animationArrowBack.play()
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    self.animationArrowBack.stop()
                    self.animationArrowBack.isHidden = true
                    self.arrowIsHidden = false
                }
            }
        }
    }
}

//MARK: - InputDataAnimationProtocol, animation arrow
extension AllMonthViewController: InputDataAnimationProtocol {
    func getValueAnimationsBool(isHidden: Bool) {
        print(" self.arrowIsHidden: \(self.arrowIsHidden)")
        self.arrowIsHidden = isHidden
        print(" self.arrowIsHidden: \(self.arrowIsHidden)")
    }
}

