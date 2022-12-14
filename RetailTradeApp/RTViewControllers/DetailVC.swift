//
//  DetailVC.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 23.11.2022.
//

import UIKit

class DetailVC: BaseController {
    
    let managerData = DataLouder.shared
    
    var animationApear = false
    var completion: ((Bool)->())?
    
    //    Пробное сохранение
    func creatItem(item: ProfitModelItem){
        let product = ProductEntity(context: managerData.context)
        product.name = item.name
        product.priceProfit = Int32(item.priceProfit)
        product.priceGross = Int32(item.priceGross)
        product.image = item.image
        managerData.save()
    }
    
//Title name vc
    private let labelTitleVC: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Ariel", size: 19)
        lbl.font = UIFont.boldSystemFont(ofSize: 19)
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.backgroundColor = .clear
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
    
//    Стек, картинка и кнопка для загрузки картинки из библиотеки
    private let stackForImage: UIStackView = {
        let stack = UIStackView()
        stack.clipsToBounds = false
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution  = .fillProportionally
        stack.backgroundColor = .systemBlue.withAlphaComponent(0.1)
        stack.layer.cornerRadius = 20
//        stack.layer.borderColor = UIColor.white.cgColor
//        stack.layer.borderWidth = 1
        return stack
    }()
    
    private var imageFromLibrary: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "photo")
        image.contentMode = .scaleAspectFit
        image.tintColor = .white
        image.layer.cornerRadius = image.frame.height / 2.0
        image.layer.masksToBounds = true
        return image
    }()
    
    private let buttonSafeImage: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.setImage(UIImage(systemName: "photo"), for: .normal)
        button.setImageTintColor(.white)
        button.setTitle("Добавить картинку", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemRed.withAlphaComponent(0.7)
        button.layer.cornerRadius = 10
        button.clipsToBounds = false
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 2
        return button
    }()
    private let buttonSafeAndMakingPhoto: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.setImage(UIImage(systemName: "camera"), for: .normal)
        button.setImageTintColor(.white)
        button.setTitle("Сделать фото", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemRed.withAlphaComponent(0.7)
        button.layer.cornerRadius = 10
        button.clipsToBounds = false
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 2
        return button
    }()
    
}

//MARK: - Used camera and library for added image
extension DetailVC {
    
    @objc private func getImageFromLibrary(){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    @objc private func getImageFromPhoneCamera(){
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
//        vc.allowsEditing = true
        present(vc, animated: true)
    }
}

//MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension DetailVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        print("\(info)")
        if let image = info[UIImagePickerController.InfoKey(rawValue:"UIImagePickerControllerEditedImage")] as? UIImage {
            imageFromLibrary.image = image
        }
        picker.dismiss(animated: true)

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

extension DetailVC {
    
    @objc private func savingData(){
        createProduct()
    }
    
    @objc private func closedView(){
        dismiss(animated: true)
    }
}

extension DetailVC {
    override func setupViews() {
        super.setupViews()
        view.addViewWithoutTAMIC(labelTitleVC)
        view.addViewWithoutTAMIC(stack)
        view.addViewWithoutTAMIC(stackForImage)
        
        stackForImage.addArrangedSubview(imageFromLibrary)
        stackForImage.addArrangedSubview(buttonSafeImage)
        stackForImage.addArrangedSubview(buttonSafeAndMakingPhoto)
        
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
            buttonSafeImage.heightAnchor.constraint(equalToConstant: 40),
            buttonSafeAndMakingPhoto.heightAnchor.constraint(equalToConstant: 40),
            imageFromLibrary.heightAnchor.constraint(equalToConstant: 200),
            
            labelTitleVC.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor, constant: 20),
            labelTitleVC.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            labelTitleVC.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            labelTitleVC.bottomAnchor.constraint(equalTo: stackForImage.topAnchor,constant:  -30),
            
          
            stackForImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackForImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -20),
            stackForImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -400),
            
            buttonSafeImage.leadingAnchor.constraint(equalTo: stackForImage.leadingAnchor, constant: 20),
            buttonSafeImage.trailingAnchor.constraint(equalTo: stackForImage.trailingAnchor, constant: -20),
            
            buttonSafeAndMakingPhoto.leadingAnchor.constraint(equalTo: stackForImage.leadingAnchor, constant: 20),
            buttonSafeAndMakingPhoto.trailingAnchor.constraint(equalTo: stackForImage.trailingAnchor, constant: -20),
            buttonSafeAndMakingPhoto.bottomAnchor.constraint(equalTo: stackForImage.bottomAnchor, constant:  -50),
    
            stack.topAnchor.constraint(equalTo: stackForImage.bottomAnchor,constant:  50),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:  -180),

            stackForButton.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 25),
            stackForButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            stackForButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            stackForButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:  -view.bounds.height / 7.7)
        ])
    }
    
    override func configureAppereance() {
        super.configureAppereance()
    
        buttonCensel.addTarget(self, action: #selector(closedView), for: .touchUpInside)
        buttonSafe.addTarget(self, action: #selector(savingData), for: .touchUpInside)
        stack.backgroundColor = .clear
        view.backgroundColor = R.Color.backgroundDetailVC
        
        buttonSafeImage.addTarget(self, action: #selector(getImageFromLibrary), for: .touchUpInside)
        buttonSafeAndMakingPhoto.addTarget(self, action: #selector(getImageFromPhoneCamera), for: .touchUpInside)
       
    }

}

extension DetailVC {
    
    func createProduct(){

        guard let textName = nameTextField.text else {
            return print("Нет имени") }
        guard let textGross = priceTextFieldGross.text else {
            return print("Нет начальной стоимости продукта")}
        guard let textProfit = priceTextFieldProfit.text else {
            return print("Нет Нет конечной стоимости продукта")}
       
        guard let image = imageFromLibrary.image else {
            return print("Нет картинки")
        }
        let saveImage = image.pngData()
        
        if textName.isEmpty || textGross.isEmpty && textProfit.isEmpty {
            print("Введите данные")
            return
        }
        let newProduct = ProfitModelItem(name: textName,
                                         priceGross: Int(textGross)!,
                                         priceProfit: Int(textProfit)!,
                                         image: saveImage
        )
        
        
        print("Создан новый товар: Имя - \(newProduct.name)")
        print("Cтоимость - \(newProduct.priceGross)")
        print("Cтоимость с наценкой - \(newProduct.priceProfit)")
        print("Картинка - \(String(describing: saveImage?.description))")
        
        if !(newProduct.name == "") {
            creatItem(item: newProduct)
            nameTextField.text = ""
            priceTextFieldGross.text = ""
            priceTextFieldProfit.text = ""
            imageFromLibrary.image = UIImage(systemName:"photo")
            animationApear = true
            completion?(animationApear)
            dismiss(animated: true)
        } else {
            animationApear = false
            dismiss(animated: true)

        }
    }
}

//MARK: - editingRowValue
extension DetailVC {
    func editingRowValue( product: ProductEntity){
        
        nameTextField.text = product.name
        priceTextFieldGross.text = String("\(product.priceGross)")
        priceTextFieldProfit.text = String("\(product.priceProfit)")
        
        guard let image = product.image else {
            return print("Ошибка в редактирование ячейки и сохранение фото")}
        imageFromLibrary.image = UIImage(data: image)
        
        if nameTextField.text == product.name && priceTextFieldGross.text == String("\(product.priceGross)") && priceTextFieldProfit.text == String("\(product.priceProfit)") {
            dismiss(animated: true)
        } else {
            guard let textName = nameTextField.text else {
                return print("Нет имени") }
            guard let textGross = priceTextFieldGross.text else {
                return print("Нет начальной стоимости продукта")}
            guard let textProfit = priceTextFieldProfit.text else {
                return print("Нет Нет конечной стоимости продукта")}
            guard let image = imageFromLibrary.image else {
                return print("Нет Нет конечной стоимости продукта")}
            let saveImage = image.pngData()
            
            if textName.isEmpty && textGross.isEmpty && textProfit.isEmpty {
                print("Введите данные")
                return
            }

            let newProduct = ProfitModelItem(name: textName,
                                             priceGross: Int(textGross)!,
                                             priceProfit: Int(textProfit)!,
                                             image: saveImage)
            
            
            
            print("Создан новый товар: Имя - \(newProduct.name)")
            print("стоимость - \(newProduct.priceGross)")
            print("стоимость с наценкой - \(newProduct.priceProfit)")
            print("Картинка изменина")

            creatItem(item: newProduct)
        }
    }
}


