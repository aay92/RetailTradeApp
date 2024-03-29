//
//  SettingViewController.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 21.11.2022.
//

import UIKit
import Lottie

class SettingViewController: BaseController {
    
    //MARK: - animaite property
    private let imageCatAndDog = LottieAnimationView(name: "dogRelax")
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
        button.setTitle(" Сохранить или загрузить данные ", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(buttonSave), for: .touchUpInside)
        button.makeSystem(button)
        return button
    }()
    
    @objc func buttonSave(){
        let host = SavingAndGettingData()
        present(host, animated: true)
    }
}

extension SettingViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.imageCatAndDog.loopMode = .loop
        self.imageCatAndDog.play()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.imageCatAndDog.loopMode = .loop
        self.imageCatAndDog.stop()
    }
    
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
            
            imageCatAndDog.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageCatAndDog.topAnchor.constraint(equalTo: view.topAnchor, constant: 20)
        ])
        
        view.addViewWithoutTAMIC(textName)
        NSLayoutConstraint.activate([
            textName.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            textName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
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
