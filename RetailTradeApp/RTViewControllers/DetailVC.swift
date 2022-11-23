//
//  DetailVC.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 23.11.2022.
//

import UIKit

class DetailVC: BaseController {
    
//    private let viewProfit: UIView = {
//        let view = UIView()
//        view.clipsToBounds = false
//        view.layer.cornerRadius = 10
//        return view
//    }()
    
//    private let imageViewMain: UIImageView = {
//        let view = UIImageView()
//        view.clipsToBounds = false
//        view.layer.cornerRadius = 10
//        view.contentMode = .scaleAspectFit
//        return view
//    }()
    private let buttonCensel: UIButton = {
        let button = UIButton()
        button.setTitle("Отмена", for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 10
        button.clipsToBounds = false
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 2
        
        return button
    }()
    
    private let buttonSafe: UIButton = {
        let button = UIButton()
        button.setTitle("Сохранить", for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 10
        button.clipsToBounds = false
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 2
        return button
    }()
    
    private let stackForButton: UIStackView = {
        let stackView = UIStackView()
        stackView.clipsToBounds = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution  = .fillEqually
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    private let stack: UIStackView = {
        let stackView = UIStackView()
        stackView.clipsToBounds = false
        stackView.axis = .vertical
        stackView.distribution  = .fillProportionally
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    
    private var nameLbl: UILabel = {
        let label = UILabel()
        label.text = "Введите название"
        label.font = UIFont(name: "Ariel", size: 25)
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private var nameTextField: UITextField = {
        let label = UITextField()
        label.placeholder = " Введите стоимость"
        label.font = UIFont(name: "Ariel", size: 15)
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .center
        label.tintColor = R.Color.backgroundDetailVC
        label.backgroundColor = .white
        label.layer.cornerRadius = 10
        return label
    }()
    
    private var priceLbl: UILabel = {
        let label = UILabel()
        label.text = "Введите стоимость"
        label.font = UIFont(name: "Ariel", size: 25)
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private var priceTextField: UITextField = {
        let label = UITextField()
        label.placeholder = "Введите стоимость"
        label.font = UIFont(name: "Ariel", size: 15)
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .center
        label.tintColor = R.Color.backgroundDetailVC
        label.backgroundColor = .white
        label.layer.cornerRadius = 10
        
        return label
    }()
    
}

extension DetailVC {
    @objc private func closedView(){
        dismiss(animated: true)
    }
}

extension DetailVC {
    override func setupViews() {
        super.setupViews()
        
        view.addViewWithoutTAMIC(stack)
        stack.addArrangedSubview(nameLbl)
        stack.addArrangedSubview(nameTextField)
        stack.addArrangedSubview(priceLbl)
        stack.addArrangedSubview(priceTextField)
        
        view.addViewWithoutTAMIC(stackForButton)
        stackForButton.addArrangedSubview(buttonSafe)
        stackForButton.addArrangedSubview(buttonCensel)

    }
    
    override func constraintViews() {
        super.constraintViews()
        NSLayoutConstraint.activate([
                        
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:  -380),
            
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            priceTextField.heightAnchor.constraint(equalToConstant: 40),
            
            stackForButton.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 25),
            stackForButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            stackForButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            stackForButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:  -view.bounds.height / 2.8),
//            button.heightAnchor.constraint(equalToConstant: 30),
//            button.widthAnchor.constraint(equalToConstant: 100),


        ])
    }
    
    override func configureAppereance() {
        super.configureAppereance()
        buttonCensel.addTarget(self, action: #selector(closedView), for: .touchUpInside)
        stack.backgroundColor = .clear
        view.backgroundColor = R.Color.backgroundDetailVC
    }

}

