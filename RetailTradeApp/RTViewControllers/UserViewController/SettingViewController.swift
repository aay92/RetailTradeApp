//
//  SettingViewController.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 21.11.2022.
//

import UIKit
import SwiftUI

class SettingViewController: BaseController {
    
    private var imageCatAndDog: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "catAndDog")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.masksToBounds = true

//      image.isUserInteractionEnabled - добавляет возможность взаимодействовать с картинкой
//        image.isUserInteractionEnabled = true
//        image.tintColor = .white
//        image.layer.cornerRadius = image.frame.height / 2.0
        return image
    }()
    
    private let textName: UILabel = {
        let label = UILabel()
        label.text = "Личный кабинет"
        label.textColor = .white.withAlphaComponent(0.7)
        label.font = UIFont(name: "Ariel", size: 13)
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let buttonSaveData: UIButton = {
        let button = UIButton()
        button.setTitle(" Сохранить данные ", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(buttonSave), for: .touchUpInside)
        button.makeSystem(button)
        return button
    }()
    
    @objc func buttonSave(){
        let host = UIHostingController(rootView: SwiftUIView())
        present(host, animated: true)
    }
    
}

extension SettingViewController {
   
    override func configureAppereance() {
        super.configureAppereance()
        title = "Настройки"
        view.backgroundColor = R.Color.background
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.white
        
    }
    override func setupViews(){
        super.setupViews()
    }
    override func constraintViews(){
        super.constraintViews()
        
        let height = UIScreen.main.bounds.height
        let width = UIScreen.main.bounds.width
        
        view.addViewWithoutTAMIC(imageCatAndDog)
        NSLayoutConstraint.activate([
            imageCatAndDog.heightAnchor.constraint(equalToConstant: 200),
            imageCatAndDog.widthAnchor.constraint(equalToConstant: 200),
            
            imageCatAndDog.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: height / 9),
            imageCatAndDog.topAnchor.constraint(equalTo: view.topAnchor, constant: 20)
        ])
        
        view.addViewWithoutTAMIC(textName)
        NSLayoutConstraint.activate([
            textName.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            
            textName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.size.height / view.frame.size.height + 140),
        ])
        
        view.addViewWithoutTAMIC(buttonSaveData)
        NSLayoutConstraint.activate([
            buttonSaveData.heightAnchor.constraint(equalToConstant: 40),
            buttonSaveData.widthAnchor.constraint(equalToConstant: 200),
            
            buttonSaveData.topAnchor.constraint(equalTo: textName.bottomAnchor, constant: width / 2),
            buttonSaveData.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            buttonSaveData.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ])
    }
}
