//
//  TabBarController.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 21.11.2022.
//

import UIKit

enum Tabs: Int, CaseIterable{
    case overview
    case allData
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
        tabBar.unselectedItemTintColor = R.Color.inactive
        tabBar.tintColor = R.Color.active
        tabBar.barTintColor = R.Color.inactive
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
            return OverviewViewController()
        case .allData:
            return AllDataViewController()
        case .setting:
            return SettingViewController()

        }
    }
    
    private func setTabBarAppearance(){
        let positionOnX : CGFloat = 30
        let positionOnY : CGFloat = 5
        let width = tabBar.bounds.width - positionOnX * 2
        let height = tabBar.bounds.height + 16
        
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
        tabBar.itemWidth = width / 5
        tabBar.itemPositioning = .centered

    }
}


