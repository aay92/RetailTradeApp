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
        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        configureAppearance()
    }
    
    private func configureAppearance(){
        tabBar.tintColor = R.Color.active
        tabBar.barTintColor = R.Color.inactive
        tabBar.backgroundColor = R.Color.background
        tabBar.layer.borderColor = R.Color.separator.cgColor
        tabBar.layer.borderWidth = 1
        tabBar.layer.masksToBounds = true
        
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

    
}


