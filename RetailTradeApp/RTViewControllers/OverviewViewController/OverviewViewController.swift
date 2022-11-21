//
//  OverviewViewController.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 20.11.2022.
//

import UIKit

class OverviewViewController: BaseController {
    
    let mainView = ProfitView()
}

extension OverviewViewController {
    override func setupViews(){
        super.setupViews()
        view.addViewWithoutTAMIC(mainView)
    }
    
    override func constraintViews(){
        super.constraintViews()
        NSLayoutConstraint.activate([
        
        ])
    }
    
    override func configureAppereance() {
        super.configureAppereance()
        view.backgroundColor = R.Color.background
        addNavButton(at: .right, with: "", image: UIImage(systemName: "plus"))
    }

}
