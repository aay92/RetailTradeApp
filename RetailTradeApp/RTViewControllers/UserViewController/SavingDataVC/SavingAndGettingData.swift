//
//  SavingAndGettingData.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 08.06.2023.
//

import UIKit

class SavingAndGettingData: BaseController {
    
    private lazy var savingButton: UIButton = {
        let button = UIButton()
        button.setTitle(" Сохранить данные ", for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(savingData), for: .touchUpInside)
        button.makeSystem(button)
        button.backgroundColor = .systemBlue
//        button.frame.size = CGSize(width: 270, height: 110)
        return button
    }()
    
    private lazy var loadingButton: UIButton = {
        let button = UIButton()
        button.setTitle(" Загрузить данные ", for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(loadingData), for: .touchUpInside)
        button.makeSystem(button)
        button.backgroundColor = .systemBlue
//        button.frame.size = CGSize(width: 170, height: 110)
        return button
    }()
    
    @objc private func savingData(){}
    @objc private func loadingData(){}

}

extension SavingAndGettingData {
    override func setupViews(){
        
    }
    override func constraintViews(){
        
        let height = UIScreen.main.bounds.height
        let width = UIScreen.main.bounds.width
        
        let stack = UIStackView()
        stack.spacing = 10
        stack.distribution = .fillEqually
        view.addViewWithoutTAMIC(stack)
        stack.addArrangedSubview(savingButton)
        stack.addArrangedSubview(loadingButton)

        NSLayoutConstraint.activate([
            stack.heightAnchor.constraint(equalToConstant: 50),
//            stack.widthAnchor.constraint(equalToConstant: 200),
            stack.topAnchor.constraint(equalTo: view.topAnchor,constant: height / 2.4),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
        ])

    }
    override func configureAppereance(){
        view.backgroundColor = R.Color.background
    }
}

