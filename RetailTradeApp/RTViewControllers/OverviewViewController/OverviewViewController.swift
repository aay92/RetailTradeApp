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
    var nawTotalProfit = 0
   
    
//    image animation
    var animateStart = false
    var imageManyArr: [UIImage] = []

//    Экземпляр базы данных
    let managerData: DataLouder
    
    //    Main collection view
    private let profitCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .clear
        collectionView.bounces = false
        collectionView.clipsToBounds = false
        return collectionView
    }()
    
    private let viewTotalProfit = ViewTotalProfit()
    
    private let imageDog: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.image = UIImage(named: "dog")
        return image
    }()
    
    private let imageMany: UIImageView = {
        let image = UIImageView()
        image.alpha = 0
        image.contentMode = .scaleAspectFit
        return image
    }()

    init(managerData: DataLouder){
        self.managerData = managerData
        super.init(nibName: nil, bundle: nil)
    }
    
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
}

//MARK: - Set controller
extension OverviewViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getSumGross()
        getSumProfit()
        profitCollectionView.reloadData()
        getTotalProfit()
        viewTotalProfit.configure(num: nawTotalProfit)
        
        if animateStart {
            UIView.animate(withDuration: 1, delay: 1) {
                self.imageMany.alpha = 1
            }
            animate(imageView: imageMany, images: imageManyArr)
            animateStart = false
            UIView.animate(withDuration: 0.9, delay: 0.9) {
                self.imageMany.alpha = 0
            }
        }
    }
  
    
    override func setupViews(){
        super.setupViews()
        
        manageObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        setDelegates()
        setCollectionView()
        view.addViewWithoutTAMIC(profitCollectionView)
        view.addViewWithoutTAMIC(viewTotalProfit)
        //        view.addViewWithoutTAMIC(imageDog)
        view.addViewWithoutTAMIC(imageMany)
        
        imageManyArr = createImageArray(total: 30, imagePrefix: "AnimationMany")
        
    }
    
    
    override func constraintViews(){
        super.constraintViews()
        NSLayoutConstraint.activate([
//            imageDog.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant:  420),
//            imageDog.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:  -60),
//            imageDog.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -120),
//            imageDog.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10),
//
//
            imageMany.heightAnchor.constraint(equalToConstant: 200),
            imageMany.widthAnchor.constraint(equalToConstant: 200),
            imageMany.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageMany.centerYAnchor.constraint(equalTo: view.centerYAnchor),


            viewTotalProfit.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            viewTotalProfit.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            viewTotalProfit.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20 ),
            viewTotalProfit.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:  -view.bounds.height / 1.32),
            
            profitCollectionView.topAnchor.constraint(equalTo: viewTotalProfit.bottomAnchor, constant: 20),
            profitCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            profitCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            profitCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.bounds.height / 1.6)
        ])
    }
    
    override func configureAppereance() {
        super.configureAppereance()
        title = "Бизнес Пёс"
        
        navigationController?.tabBarItem.title = R.TabBar.title(for: Tabs.overview)
        var nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.white
        
        view.backgroundColor = R.Color.background
        viewTotalProfit.layer.cornerRadius = 10
        viewTotalProfit.clipsToBounds = true
        
//        Bottom added item
        addNavButton(at: .right, with: "", image: UIImage(systemName: "plus"))
        
    }
    
    
    
}

//MARK: - add Segue On DetailVC
extension OverviewViewController {
    
    override func navBarRightButtonHandler(){
        let detailVC = DetailVC()
        detailVC.modalPresentationStyle = .fullScreen
        detailVC.completion = {[weak self] i in
            guard let self = self else { return }
            print("Bool \(i)")
            self.animateStart = i
            
        }
       
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
                .init(widthDimension: .fractionalWidth(1),
                      heightDimension: .absolute(105)))
        item.contentInsets.leading = 10
        item.contentInsets.trailing = 10
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize:
                .init(widthDimension: .fractionalWidth(0.8),
                      heightDimension: .estimated(600)),subitems: [item])
        
        group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let section = settingCollectionLayoutSection(group: group,
                                                     behavior: .continuous,
                                                     intetGroupSpacing: 0,
                                                     supplementaryItems: [],
                                                     contentInsets: false)
        return section
    }
    
}

//MARK: - Summa in items CollectionView and Main view
extension OverviewViewController {
    
    private func getSumProfit() {
        var productsProfit = [ProductEntity]()
        let eventRequest: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()
        
        do {
            productsProfit = try! manageObjectContext.fetch(eventRequest)
            let sum = productsProfit.reduce(0) {$0 + ($1.priceProfit)}
            print("While iteration newSum: \(sum)")
            self.nawProductsProfit = Int(sum)
            print("Value save: \(nawProductsProfit)")

        } catch {
            print("Could not load save data: \(error.localizedDescription)")
        }
        print("Summa nawProductsProfit: \(nawProductsProfit)")
    }
    
    private func getSumGross() {
        var productsGross = [ProductEntity]()
        let eventRequest: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()
        
        do {
            productsGross = try! manageObjectContext.fetch(eventRequest)
            let sum = productsGross.reduce(0) {$0 + ($1.priceGross)}
            print("While iteration newSum: \(sum)")
            nawProductsGross = Int(sum)
            print("Value save: \(nawProductsGross)")
        } catch {
            print("Could not load save data: \(error.localizedDescription)")
        }
        print("Summa nawProductsGross: \(nawProductsGross)")
    }
    
    private func getTotalProfit(){
        
        var productsGross = [ProductEntity]()
        var productsProfit = [ProductEntity]()

        let eventRequest: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()
        
        do {
            productsGross = try! manageObjectContext.fetch(eventRequest)
            let sumGross = productsGross.reduce(0) {$0 + ($1.priceGross)}
            
            productsProfit = try! manageObjectContext.fetch(eventRequest)
            let sumProfit = productsProfit.reduce(0) {$0 + ($1.priceProfit)}
            
            print("While iteration sumGross: \(sumGross)")
            nawProductsGross = Int(sumGross)
            
            print("While iteration sumProfit: \(sumProfit)")
            nawProductsProfit = Int(sumProfit)
            
            nawTotalProfit = nawProductsGross - nawProductsProfit

            print("Value NawTotalProfit: \(nawTotalProfit)")
            
            print("Value save: \(nawProductsGross)")
        } catch {
            print("Could not load save data: \(error.localizedDescription)")
        }
    }
}

//MARK: - Animation gif after successful added item
extension OverviewViewController {
    
    func createImageArray(total: Int, imagePrefix: String)-> [UIImage]{
        var imageArr: [UIImage] = []
        
        for imageCont in 1..<total {
            let imageName = "\(imageCont)"
            let image = UIImage(named: imageName)!
            imageArr.append(image)
        }
        return imageArr
    }
    func animate(imageView: UIImageView, images: [UIImage]){
    
        imageView.animationImages = images
        imageView.animationDuration = 0.85
        imageView.animationRepeatCount = 5
        imageView.startAnimating()
    }
}
