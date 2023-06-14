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
    
    //MARK: - blur property
    private let animationBlurImageView = LottieAnimationView(name: "blurAnimate")

    //MARK: - animation property
    private let animationArrowBack = LottieAnimationView(name: "arrowBack")
    var arrowIsHidden = false
    
    //MARK: - dataFlowFromCoreData
    var manageObjectContext: NSManagedObjectContext!
    var month = [ModelOverview]()
    var monthFilter = [ModelOverview]()

    let tableViewProducts : UITableView = {
        let table = UITableView()
        table.register(MonthTableViewCell.self, forCellReuseIdentifier: MonthTableViewCell.identifier)
        return table
    }()
   var dateCreated = Date()

}


extension AllMonthViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animationTableViewCell()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        manageObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        self.loadSaveData()
        animationArrowBackAction()
//        animationTableViewCell()
    }
    
    override func setupViews() {
        super.setupViews()
        
        manageObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        loadSaveData()
        
        print("Количество продуктов в массиве: \(month.count)")
        setDelegate()
        
        view.addViewWithoutTAMIC(tableViewProducts)
        view.addViewWithoutTAMIC(animationArrowBack)
        view.addViewWithoutTAMIC(animationBlurImageView)
        
        animationBlurImageView.isHidden = true
        animationArrowBack.isHidden = true
    }
    
    func loadSaveData() {
        let eventRequest: NSFetchRequest<ModelOverview> = ModelOverview.fetchRequest()
        do {
            month = try manageObjectContext.fetch(eventRequest)
//            monthFilter = month.predicate [NSSortDescriptor(key: "date", ascending: true)]

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
            
            animationBlurImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationBlurImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            animationBlurImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height),
            animationBlurImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),

            animationArrowBack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationArrowBack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            animationArrowBack.heightAnchor.constraint(equalToConstant: 700),
        ])
    }
    
    override func configureAppereance() {
        super.configureAppereance()
        title = "Доходы по месяцам"
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
        let mouths = self.month[indexPath.row]
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
//MARK: - animationTableViewCell
extension AllMonthViewController {
    func animationTableViewCell(){
        
        let cells = self.tableViewProducts.visibleCells
        let tableViewWidth = tableViewProducts.bounds.width
        var indexCell: Double = 0

        for cell in cells {
            cell.transform = CGAffineTransform(translationX: tableViewWidth / 0.85, y: 0)

            UIView.animate(withDuration: 1.9,
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

//MARK: - animationArrowBackAction
extension AllMonthViewController {
    ///animationArrowBackAction - Выводит анимацию, когда сохранили месяц и перешли на страницу с месецами
    func animationArrowBackAction(){

        self.animationArrowBack.transform = CGAffineTransform(translationX: -400, y: 0)

        if arrowIsHidden {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                UIView.animate(withDuration: 1.5,
                               delay: 0.05,
                               usingSpringWithDamping: 0.7,
                               initialSpringVelocity: 0.7,
                               options: .curveEaseInOut) {
                    self.animationArrowBack.transform = CGAffineTransform(translationX: 0, y: 0)
                }
                self.animationArrowBack.transform = CGAffineTransform(rotationAngle: .pi / 2)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.animationArrowBack.isHidden = false
                    self.animationArrowBack.loopMode = .loop
                    self.animationArrowBack.play()
                    self.animationArrowBack.alpha = 1
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    UIView.animate(withDuration: 1.5,
                                   delay: 0.05,
                                   usingSpringWithDamping: 0.7,
                                   initialSpringVelocity: 0.8,
                                   options: .curveEaseInOut) {
                        self.animationArrowBack.transform = CGAffineTransform(translationX: -400, y: 0)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.animationArrowBack.alpha = 0.0
                            self.animationArrowBack.isHidden = true
                            self.animationArrowBack.stop()
                            self.arrowIsHidden = false
                            self.animationArrowBack.transform = CGAffineTransform(rotationAngle: .pi / 2)
                        }
                    }
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

//MARK: - blur
extension AllMonthViewController {

    private func startAnimateBlurImageView() {
        UIView.animate(withDuration: 1.5, animations: {
            self.animationBlurImageView.frame.origin.y = -25
        }) {_ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                UIView.animate(withDuration: 1.0) {
                    self.animationBlurImageView.frame.origin.y = -1000
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.animationBlurImageView.isHidden = true
                        self.animationBlurImageView.stop()
                    }
                }
            }
        }
    }
}
