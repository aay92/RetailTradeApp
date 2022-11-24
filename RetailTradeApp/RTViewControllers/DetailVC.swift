//
//  DetailVC.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 23.11.2022.
//

import UIKit

class DetailVC: BaseController {
    
//Title name vc
    private let labelTitleVC: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Ariel", size: 19)
        lbl.font = UIFont.boldSystemFont(ofSize: 19)
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.text = "Введите новую продажу"
        return lbl
    }()
    
    
//    Stack buttom
    private let stackForButton: UIStackView = {
        let stackView = UIStackView()
        stackView.clipsToBounds = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution  = .fillEqually
        stackView.backgroundColor = .clear
        return stackView
    }()
    
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
    
//    Главный стек
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
        label.placeholder = " Введите название"
        label.font = UIFont(name: "Ariel", size: 15)
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .center
        label.tintColor = R.Color.backgroundDetailVC
        label.backgroundColor = .white
        label.layer.cornerRadius = 10
        return label
    }()
    
//    Стек с двумя стеками
    private let stackForTextFieldsPrices: UIStackView = {
        let stackView = UIStackView()
        stackView.clipsToBounds = false
        stackView.axis = .horizontal
        stackView.distribution  = .fillEqually
        stackView.backgroundColor = .clear
        stackView.spacing = 25

        return stackView
    }()
    
    private let stackProfit: UIStackView = {
        let stackView = UIStackView()
        stackView.clipsToBounds = false
        stackView.axis = .vertical
        stackView.distribution  = .fillProportionally
        stackView.backgroundColor = .clear
        stackView.spacing = 10
        return stackView
    }()
    
    private let stackGross: UIStackView = {
        let stackView = UIStackView()
        stackView.clipsToBounds = false
        stackView.axis = .vertical
        stackView.distribution  = .fillProportionally
        stackView.backgroundColor = .clear
        stackView.spacing = 10

        return stackView
    }()
    
    
    private var priceLblGross: UILabel = {
        let label = UILabel()
        label.text = "Введите конечную стоимость"
        label.font = UIFont(name: "Ariel", size: 15)
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private var priceTextFieldGross: UITextField = {
        let label = UITextField()
        label.placeholder = "Введите данные"
        label.font = UIFont(name: "Ariel", size: 13)
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .black
        label.textAlignment = .center
        label.tintColor = R.Color.backgroundDetailVC
        label.backgroundColor = .white
        label.layer.cornerRadius = 10
        
        return label
    }()
    
    private var priceLblProfit: UILabel = {
        let label = UILabel()
        label.text = "Введите стоимость по закупке"
        label.font = UIFont(name: "Ariel", size: 15)
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private var priceTextFieldProfit: UITextField = {
        let label = UITextField()
        label.placeholder = "Введите данные"
        label.font = UIFont(name: "Ariel", size: 13)
        label.font = UIFont.boldSystemFont(ofSize: 13)
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
        view.addViewWithoutTAMIC(labelTitleVC)
        view.addViewWithoutTAMIC(stack)
        
        stack.addArrangedSubview(nameLbl)
        stack.addArrangedSubview(nameTextField)
        stack.addArrangedSubview(stackForTextFieldsPrices)
        
        stackForTextFieldsPrices.addArrangedSubview(stackProfit)
        stackForTextFieldsPrices.addArrangedSubview(stackGross)
        
        stackProfit.addArrangedSubview(priceLblProfit)
        stackProfit.addArrangedSubview(priceTextFieldProfit)

        stackGross.addArrangedSubview(priceLblGross)
        stackGross.addArrangedSubview(priceTextFieldGross)

        view.addViewWithoutTAMIC(stackForButton)
        stackForButton.addArrangedSubview(buttonSafe)
        stackForButton.addArrangedSubview(buttonCensel)

    }
    
    override func constraintViews() {
        super.constraintViews()
        NSLayoutConstraint.activate([
            
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            priceTextFieldGross.heightAnchor.constraint(equalToConstant: 40),
            priceTextFieldProfit.heightAnchor.constraint(equalToConstant: 40),
            
            labelTitleVC.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            labelTitleVC.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            labelTitleVC.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            labelTitleVC.bottomAnchor.constraint(equalTo: stack.topAnchor, constant:  -350),
                        
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 400),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:  -180),

            stackForButton.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 25),
            stackForButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            stackForButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            stackForButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:  -view.bounds.height / 7.5),


        ])
    }
    
    override func configureAppereance() {
        super.configureAppereance()
    
        buttonCensel.addTarget(self, action: #selector(closedView), for: .touchUpInside)
        stack.backgroundColor = .clear
        view.backgroundColor = R.Color.backgroundDetailVC
    }

}

