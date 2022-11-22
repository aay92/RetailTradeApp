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
//        view.backgroundColor = R.Color.background
        navigationBar.isTranslucent = false
        
//        navigationBar.standardAppearance.titleTextAttributes = [
//            .foregroundColor: Resources.Color.darkGray,
//            .font: Resources.Fonts.helvelticaRegular(with: 16)]
//
//        navigationBar.addBottomBorder(with: Resources.Color.separator, height: 1)
    }
}
