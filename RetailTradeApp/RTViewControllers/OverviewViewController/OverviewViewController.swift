//
//  OverviewViewController.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 20.11.2022.
//

import UIKit

class OverviewViewController: BaseController {
    
//    Экземпляр базы данных
    let managerData: DataLouder
    
    init(managerData: DataLouder){
        self.managerData = managerData
        super.init(nibName: nil, bundle: nil)
    }
    
//    Пробное сохранение
    func creatItem(){
        let product = ProductEntity(context: managerData.context)
        product.name = "Часы"
        
        managerData.save()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let collectionSection: [ProfitItemInCollectionView] = [
        .init(name: "Прибль",
              sum: 1230103),
        .init(name: "Доход",
              sum: 760740),
    ]
    
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
        setDelegates()
        setCollectionView()
        view.addViewWithoutTAMIC(profitCollectionView)
        
        creatItem()
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
        return collectionSection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                                                                ProfitCell.identifier, for: indexPath) as? ProfitCell
        else {
            return UICollectionViewCell()
        }
        cell.setUp(category: collectionSection[indexPath.row])
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
