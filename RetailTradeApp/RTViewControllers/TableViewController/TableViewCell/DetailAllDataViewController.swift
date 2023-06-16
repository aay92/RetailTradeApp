//
//  DetailAllDataViewController.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 14.06.2023.
//
import UIKit
import SwiftUI

class DetailAllDataViewController: BaseController {
    
    
    private var mainImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "photo")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        //      image.isUserInteractionEnabled - добавляет возможность взаимодействовать с картинкой
        image.isUserInteractionEnabled = true
        image.tintColor = .white
//        image.layer.cornerRadius = image.frame.height / 2.0
        return image
    }()
    
    private let mainLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Ariel", size: 20)
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.backgroundColor = .clear
        lbl.text = "Название позиции"
        return lbl
    }()
    
    private let costPriceProfit: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Ariel", size: 18)
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.textColor = .white
        lbl.textAlignment = .left
        lbl.backgroundColor = .clear
        lbl.text = "Cтоимость позиции на продаже: "
        return lbl
    }()
    
    private let costPriceGross: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Ariel", size: 18)
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.textColor = .white
        lbl.textAlignment = .left
        lbl.backgroundColor = .clear
        lbl.text = "Cебестоимость позиции: "
        return lbl
    }()
    
    private let costTotal: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Ariel", size: 19)
        lbl.font = UIFont.boldSystemFont(ofSize: 19)
        lbl.textColor = .systemRed
        lbl.textAlignment = .left
        lbl.backgroundColor = .clear
        lbl.text = "Прибыль с позиции: "
        return lbl
    }()
    
    
    func configure(name: String, imageItem: Data? = nil, costPositionPrf: Int, costPriceGrs: Int, total: Int){
        guard let image = imageItem?.base64EncodedData() else { return }
        mainImage.image = UIImage(data: image)
        mainLabel.text = name
        costPriceProfit.text = "Cтоимость позиции на продаже: " + String(costPositionPrf)
        costPriceGross.text = "Cебестоимость позиции: " + String(costPriceGrs)
        costTotal.text = "Прибыль с позиции: " + String(total)
    }
    

//
//
//
//
//    //    Stack button
//    private let stackForButton: UIStackView = {
//        let stackView = UIStackView()
//        stackView.clipsToBounds = false
//        stackView.axis = .horizontal
//        stackView.spacing = 10
//        stackView.distribution  = .fillEqually
//        stackView.backgroundColor = .clear
//        return stackView
//    }()
//
//    private let buttonCancel: UIButton = {
//        let button = UIButton()
//        button.setTitle("Отмена", for: .normal)
//        button.backgroundColor = .clear
//        button.layer.cornerRadius = 10
//        button.clipsToBounds = false
//        button.layer.borderColor = UIColor.white.cgColor
//        button.layer.borderWidth = 2
//        return button
//    }()
//
//    private let buttonSafe: UIButton = {
//        let button = UIButton()
//        button.setTitle("Сохранить", for: .normal)
//        button.backgroundColor = .clear
//        button.layer.cornerRadius = 10
//        button.clipsToBounds = false
//        button.layer.borderColor = UIColor.white.cgColor
//        button.layer.borderWidth = 2
//        return button
//    }()
//
//    //    Главный стек
//    private let stack: UIStackView = {
//        let stackView = UIStackView()
//        stackView.clipsToBounds = false
//        stackView.axis = .vertical
//        stackView.distribution  = .fillProportionally
//        stackView.backgroundColor = .clear
//        return stackView
//    }()
//
//    private let stackForName: UIStackView = {
//        let stackView = UIStackView()
//        stackView.clipsToBounds = false
//        stackView.axis = .horizontal
//        stackView.backgroundColor = .clear
//        return stackView
//    }()
//
//    private var chooseDate: UILabel = {
//        let label = UILabel()
//        label.text = "Выберите дату"
//        label.font = UIFont(name: "Ariel", size: 15)
//        label.textAlignment = .right
//        label.font = UIFont.boldSystemFont(ofSize: 15)
//        return label
//    }()
//
//    private var nameLbl: UILabel = {
//        let label = UILabel()
//        label.text = "Введите название"
//        label.font = UIFont(name: "Ariel", size: 25)
//        label.font = UIFont.boldSystemFont(ofSize: 25)
//        label.textColor = .white
//        label.textAlignment = .left
//        label.numberOfLines = 0
//        return label
//    }()
//
//    private var nameTextField: UITextField = {
//        let label = UITextField()
//        label.placeholder = " Введите название"
//        label.font = UIFont(name: "Ariel", size: 15)
//        label.font = UIFont.boldSystemFont(ofSize: 15)
//        label.textColor = .black
//        label.textAlignment = .center
//        label.tintColor = R.Color.backgroundDetailVC
//        label.backgroundColor = .white
//        label.layer.cornerRadius = 10
//        return label
//    }()
//
//    //    Стек с двумя стеками
//    private let stackForTextFieldsPrices: UIStackView = {
//        let stackView = UIStackView()
//        stackView.clipsToBounds = false
//        stackView.axis = .horizontal
//        stackView.distribution  = .fillEqually
//        stackView.backgroundColor = .clear
//        stackView.spacing = 25
//
//        return stackView
//    }()
//
//    private let stackProfit: UIStackView = {
//        let stackView = UIStackView()
//        stackView.clipsToBounds = false
//        stackView.axis = .vertical
//        stackView.distribution  = .fillProportionally
//        stackView.backgroundColor = .clear
//        stackView.spacing = 10
//        return stackView
//    }()
//
//    private let stackGross: UIStackView = {
//        let stackView = UIStackView()
//        stackView.clipsToBounds = false
//        stackView.axis = .vertical
//        stackView.distribution  = .fillProportionally
//        stackView.backgroundColor = .clear
//        stackView.spacing = 10
//
//        return stackView
//    }()
//
//    private var priceLblGross: UILabel = {
//        let label = UILabel()
//        label.text = "Введите конечную стоимость"
//        label.font = UIFont(name: "Ariel", size: 15)
//        label.font = UIFont.boldSystemFont(ofSize: 15)
//        label.textColor = .white
//        label.textAlignment = .left
//        label.numberOfLines = 0
//        return label
//    }()
//
//    private var priceTextFieldGross: UITextField = {
//        let label = UITextField()
//        label.placeholder = "Введите данные"
//        label.font = UIFont(name: "Ariel", size: 13)
//        label.font = UIFont.boldSystemFont(ofSize: 13)
//        label.textColor = .black
//        label.textAlignment = .center
//        label.keyboardType = .numberPad
//        label.tintColor = R.Color.backgroundDetailVC
//        label.backgroundColor = .white
//        label.layer.cornerRadius = 10
//        return label
//    }()
//
//    private var priceLblProfit: UILabel = {
//        let label = UILabel()
//        label.text = "Введите стоимость по закупке"
//        label.font = UIFont(name: "Ariel", size: 15)
//        label.font = UIFont.boldSystemFont(ofSize: 15)
//        label.textColor = .white
//        label.textAlignment = .left
//        label.numberOfLines = 0
//        return label
//    }()
//
//    private var priceTextFieldProfit: UITextField = {
//        let label = UITextField()
//        label.placeholder = "Введите данные"
//        label.font = UIFont(name: "Ariel", size: 13)
//        label.font = UIFont.boldSystemFont(ofSize: 13)
//        label.textColor = .black
//        label.keyboardType = .numberPad
//        label.textAlignment = .center
//        label.tintColor = R.Color.backgroundDetailVC
//        label.backgroundColor = .white
//        label.layer.cornerRadius = 10
//        return label
//    }()
//
//    //    Стек, картинка и кнопка для загрузки картинки из библиотеки
//    private let stackForImage: UIStackView = {
//        let stack = UIStackView()
//        stack.clipsToBounds = false
//        stack.axis = .vertical
//        stack.spacing = 10
//        stack.distribution  = .fillEqually
//        stack.backgroundColor = .systemBlue.withAlphaComponent(0.1)
//        stack.layer.cornerRadius = 20
//        return stack
//    }()
//
//
//    private let buttonSafeImage: UIButton = {
//        let button = UIButton()
//        button.layer.cornerRadius = 10
//        button.setImage(UIImage(systemName: "photo"), for: .normal)
//        button.setImageTintColor(.white)
//        button.setTitle("Добавить картинку", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.backgroundColor = .systemRed.withAlphaComponent(0.7)
//        button.layer.cornerRadius = 10
//        button.clipsToBounds = false
//        button.layer.borderColor = UIColor.white.cgColor
//        button.layer.borderWidth = 2
//        return button
//    }()
//    private let buttonSafeAndMakingPhoto: UIButton = {
//        let button = UIButton()
//        button.layer.cornerRadius = 10
//        button.setImage(UIImage(systemName: "camera"), for: .normal)
//        button.setImageTintColor(.white)
//        button.setTitle("Сделать фото", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.backgroundColor = .systemRed.withAlphaComponent(0.7)
//        button.layer.cornerRadius = 10
//        button.clipsToBounds = false
//        button.layer.borderColor = UIColor.white.cgColor
//        button.layer.borderWidth = 2
//        return button
//    }()
//
}

extension DetailAllDataViewController {
    
    override func setupViews() {
        super.setupViews()
    }
    
    override func constraintViews(){
        super.constraintViews()
        view.addViewWithoutTAMIC(mainImage)
        view.addViewWithoutTAMIC(mainLabel)
        view.addViewWithoutTAMIC(costPriceGross)
        view.addViewWithoutTAMIC(costPriceProfit)
        view.addViewWithoutTAMIC(costTotal)

        
        NSLayoutConstraint.activate([
            mainImage.topAnchor.constraint(equalTo: view.topAnchor),
            mainImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.frame.height / 2),
            
            mainLabel.heightAnchor.constraint(equalToConstant: 50),
            mainLabel.topAnchor.constraint(equalTo: mainImage.bottomAnchor, constant:  20),
            mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            mainLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            costPriceGross.heightAnchor.constraint(equalToConstant: 50),
            costPriceGross.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant:  10),
            costPriceGross.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            costPriceGross.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            
            costPriceProfit.heightAnchor.constraint(equalToConstant: 50),
            costPriceProfit.topAnchor.constraint(equalTo: costPriceGross.bottomAnchor, constant:  5),
            costPriceProfit.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            costPriceProfit.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            
            costTotal.heightAnchor.constraint(equalToConstant: 50),
            costTotal.topAnchor.constraint(equalTo: costPriceProfit.bottomAnchor, constant: 10),
            costTotal.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            costTotal.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
        ])
    }
    override func configureAppereance() {
        super.configureAppereance()
        view.backgroundColor = R.Color.background
    }
    
}
