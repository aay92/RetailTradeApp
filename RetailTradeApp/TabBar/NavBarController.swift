//
//  NavBarController.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 21.11.2022.
//


import UIKit

final class NavBarController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppereance()
    }
    
    private func configureAppereance(){
        navigationBar.isTranslucent = false
    }
}
