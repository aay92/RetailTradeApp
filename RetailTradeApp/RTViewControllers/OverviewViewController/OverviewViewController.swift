//
//  OverviewViewController.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 20.11.2022.
//

import UIKit
import CoreData

class OverviewViewController: BaseController {
    var manageObjectContext: NSManagedObjectContext!
    var nawProductsProfit = 0
    var nawProductsGross = 0


//    Экземпляр базы данных
    let managerData: DataLouder
    
    var productsProfit = 0
    var productsGross = 0

    init(managerData: DataLouder){
        self.managerData = managerData
        super.init(nibName: nil, bundle: nil)
    }
    
    func printsPtoductsFromData(){
//        productsProfit.forEach({ print( $0.name )})
//        productsProfit.forEach({ print( $0.priceGross )})
//        productsProfit.forEach({ print( $0.priceProfit )})

    }
    
//    func getFetch() {
//        let products = managerData.fetchProductData(ProductEntity.self)
//        self.productsProfit = products
//
//        printsPtoductsFromData()
//
//        let deadLine = DispatchTime.now() + .seconds(5)
////        DispatchQueue.main.asyncAfter(deadline: deadLine, execute: deleteProducts)
//    }
//
//    func updateProducts(){
//        let firstProduct = productsProfit.first!
//        firstProduct.name! += "- new data new data"
//        managerData.save()
//
//        printsPtoductsFromData()
//    }
//
//    func deleteProducts(){
//        let fitstProduct = products.first!
//
//        managerData.delete(fitstProduct)
//        printsPtoductsFromData()
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSum()->[ProfitItemInCollectionView]{
        var arrayCollectionView = [ProfitItemInCollectionView]()
        let profitItem = ProfitItemInCollectionView(name: "Pribl", sumGross: nawProductsGross, sumProfit: nawProductsProfit)
        
        let groosItem = ProfitItemInCollectionView(name: "Extra", sumGross: nawProductsGross, sumProfit: nawProductsProfit)
        arrayCollectionView.append(profitItem)
        arrayCollectionView.append(groosItem)
        
        return arrayCollectionView
    }
    
    //    Main collection view
    private let profitCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .clear
        collectionView.bounces = false
        collectionView.clipsToBounds = false
        return collectionView
    }()
}

//MARK: - Set controller
extension OverviewViewController {
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getSumGross()
        getSumProfit()
        profitCollectionView.reloadData()
    }
   
    override func setupViews(){
        super.setupViews()
        
        manageObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
           self.getSumProfit()
        
        managerData.fetchProductData(ProductEntity.self).forEach({item in
            productsGross = Int(item.priceGross)
            productsProfit = Int(item.priceProfit)
        })
        
        setDelegates()
        setCollectionView()
        view.addViewWithoutTAMIC(profitCollectionView)

//        getSumGross()
//        getSumProfit()

    }
    
    
    override func constraintViews(){
        super.constraintViews()
        NSLayoutConstraint.activate([
            profitCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            profitCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            profitCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            profitCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:  -550)
        ])
    }
    
    override func configureAppereance() {
        super.configureAppereance()
        title = "Черная Торговля"
        
        navigationController?.tabBarItem.title = R.TabBar.title(for: Tabs.overview)
        var nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.white
        
        view.backgroundColor = R.Color.background
//        Bottom added item
        addNavButton(at: .right, with: "", image: UIImage(systemName: "plus"))
    }
    
    
    
}

//MARK: - add Segue On DetailVC
extension OverviewViewController {
    
    override func navBarRightButtonHandler(){
        let detailVC = DetailVC()
        navigationController?.present(detailVC, animated: true)
    }

}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension OverviewViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    private func setDelegates(){
        self.profitCollectionView.delegate = self
        self.profitCollectionView.dataSource = self
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return setSum().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                                                                ProfitCell.identifier, for: indexPath) as? ProfitCell
        else {
            return UICollectionViewCell()
        }
        cell.setUp(category: setSum()[indexPath.row])
        return cell
    }
}


//MARK: - Set create Layout
extension OverviewViewController {
    
    private func createLayout()-> UICollectionViewCompositionalLayout{
        UICollectionViewCompositionalLayout {[weak self] index, _ in
            
            guard let self = self else { return nil }
            //            let section = self.sections[index]
            return self.createProfitCollectionView()
        }
    }
    
    private func setCollectionView(){
        self.profitCollectionView.register(ProfitCell.self, forCellWithReuseIdentifier: ProfitCell.identifier)
        self.profitCollectionView.collectionViewLayout = createLayout()
    }
    
    //       Быстрые настройки секции коллекции
    private func settingCollectionLayoutSection(group: NSCollectionLayoutGroup,
                                                behavior: UICollectionLayoutSectionOrthogonalScrollingBehavior,
                                                intetGroupSpacing: CGFloat,
                                                supplementaryItems: [NSCollectionLayoutBoundarySupplementaryItem],
                                                contentInsets: Bool)-> NSCollectionLayoutSection{
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = behavior
        section.interGroupSpacing = intetGroupSpacing
        section.boundarySupplementaryItems = supplementaryItems
        section.supplementariesFollowContentInsets = contentInsets
        return section
    }
    
    
    private func createProfitCollectionView()-> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize:
                .init(widthDimension: .fractionalWidth(0.80),
                      heightDimension: .absolute(150)))
        item.contentInsets.leading = 10
//        item.contentInsets.bottom = 9
        let group = NSCollectionLayoutGroup.horizontal(layoutSize:
                .init(widthDimension: .fractionalWidth(1),
                      heightDimension: .estimated(600)),subitems: [item])
        
        group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let section = settingCollectionLayoutSection(group: group,
                                                     behavior: .continuous,
                                                     intetGroupSpacing: -50,
                                                     supplementaryItems: [],
                                                     contentInsets: false)
        //        section.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
        return section
    }
    
}

//MARK: - Summa in items CollectionView
extension OverviewViewController {
    func getSumProfit() {
        var productsProfit = [ProductEntity]()
        let eventRequest: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()
        
        do {
            productsProfit = try! manageObjectContext.fetch(eventRequest)
            let sum = productsProfit.reduce(0) {$0 + ($1.priceProfit as? Int32 ?? 0)}
            print("While iteration newSum: \(sum)")
            self.nawProductsProfit = Int(sum)
        } catch {
            print("Could not load save data: \(error.localizedDescription)")
        }
        print("Summa: \(nawProductsProfit)")

    }
    
    func getSumGross() {
        var productsGross = [ProductEntity]()
        let eventRequest: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()
        
        do {
            productsGross = try! manageObjectContext.fetch(eventRequest)
            let sum = productsGross.reduce(0) {$0 + ($1.priceGross as? Int32 ?? 0)}
            print("While iteration newSum: \(sum)")
            self.nawProductsGross = Int(sum)
        } catch {
            print("Could not load save data: \(error.localizedDescription)")
        }
        print("Summa: \(nawProductsGross)")

    }
}
