//
//  OverviewViewController.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 20.11.2022.
//

import UIKit
import CoreData

class OverviewViewController: BaseController {
    
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
        let profitItem = ProfitItemInCollectionView(name: "Pribl", sumGross: productsGross, sumProfit: productsProfit)
        
        let groosItem = ProfitItemInCollectionView(name: "Extra", sumGross: productsGross, sumProfit: productsProfit)
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
    override func setupViews(){
        super.setupViews()
        
        managerData.fetchProductData(ProductEntity.self).forEach({item in
            productsGross = Int(item.priceGross)
            productsProfit = Int(item.priceProfit)
        })
        
        setDelegates()
        setCollectionView()
        view.addViewWithoutTAMIC(profitCollectionView)
        
//        creatItem()
//        getFetchProduct()
//        updateProducts()
    }
    
//    func getFetchProduct(){
//        managerData.fetchProductData(ProductEntity.self).forEach({item in
//            productsGross.append(item.priceGross)
//            productsProfit.append(item.priceProfit)
//        })
//    }
    
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
        detailVC.delegate = self
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
//        cell.setUpData(titel: "Прибыль", productsGross: productsGross[indexPath.row], productsProfit: productsProfit[indexPath.row])
        cell.setUp(category: setSum()[indexPath.row])
        return cell
    }
    
    
}


//Set create Layout
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

extension OverviewViewController: BackMakingProduct {
    func getProduct(item: ProfitModelItem) {
//        guard String(item.name) == nil else { return }
//        guard item.priceGross != nil else { return }
//        guard item.priceProfit != nil else { return }

        let product = ProductEntity(context: managerData.context)
//
        product.name = item.name
        product.priceGross = Int32(item.priceGross)
        product.priceProfit = Int32(item.priceProfit)
        managerData.save()

//        products.append(product)
        print("Продукт добавлен")

    }
    
    
}
