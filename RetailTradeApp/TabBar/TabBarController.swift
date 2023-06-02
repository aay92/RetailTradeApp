//
//  TabBarController.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 21.11.2022.
//

import UIKit

enum Tabs: Int, CaseIterable {
    case overview
    case allData
    case allMonth
    case setting
}

class TabBarController: UITabBarController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setTabBarAppearance()
        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        setTabBarAppearance()
        configureAppearance()
    }
    
    private func configureAppearance(){
        //Clear background
        tabBar.backgroundColor = .clear
        tabBar.barTintColor = .clear
        tabBar.backgroundImage = UIImage()
        //Set color for tabBar
        tabBar.unselectedItemTintColor = R.Color.inactive.withAlphaComponent(0.5)
        tabBar.tintColor = R.Color.tabBatColorActive
        tabBar.layer.masksToBounds = false
        
        let controller: [NavBarController] = Tabs.allCases.map { tab in
            let controller = NavBarController(rootViewController: getController(for: tab))
            controller.tabBarItem = UITabBarItem(title: R.TabBar.title(for: tab),
                                                 image: R.Images.TabBar.icon(for: tab),
                                                 tag: tab.rawValue)

            return controller
        }
        setViewControllers(controller, animated: true)
    }
    
    private func getController(for tab: Tabs) -> BaseController {
        switch tab {
        case .overview:
            //    Экземпляр базы данных через сингл тон
            return OverviewViewController(managerData: DataLouder.shared)
        case .allData:
            let view = AllDataViewController()
            view.tableViewProducts.reloadData()
            return view
        case .allMonth:
            return AllMonthViewController()
        case .setting:
            return SettingViewController()
        }

    }
    
    private func setTabBarAppearance(){
        let positionOnX : CGFloat = 5
        let positionOnY : CGFloat = 5
        let width = tabBar.bounds.width - positionOnX * 2
        let height = tabBar.bounds.height + 20
        
        let roundLayer = CAShapeLayer()
        let bezierPath = UIBezierPath(roundedRect: CGRect(x: positionOnX,
                                                          y: tabBar.bounds.midY - 30,
                                                          width: width,
                                                          height: height
                                                         ),
                                      cornerRadius: height / 2
        )
        
        roundLayer.path = bezierPath.cgPath
        
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        tabBar.itemWidth = width / 5.5
        tabBar.itemPositioning = .centered
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 1) {
            self.tabBar.transform = CGAffineTransform(scaleX: 2, y: 2)
            self.tabBar.transform = CGAffineTransform(scaleX: 1, y: 1)
        }

    }
}

