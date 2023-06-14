//
//  DetailVC.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 23.11.2022.
//

import UIKit


class DetailVC: BaseController {
    
    let managerData = DataLouder.shared
    var timeDate = ""

    var animationApear = false
    var completion: ((Bool)->())?
    
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
    
    private let stackForName: UIStackView = {
        let stackView = UIStackView()
        stackView.clipsToBounds = false
        stackView.axis = .horizontal
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    private var chooseDate: UILabel = {
        let label = UILabel()
        label.text = "Выбирите дату"
        label.font = UIFont(name: "Ariel", size: 15)
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
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
        label.keyboardType = .numberPad
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
        label.keyboardType = .numberPad
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
        stack.distribution  = .fillEqually
        stack.backgroundColor = .systemBlue.withAlphaComponent(0.1)
        stack.layer.cornerRadius = 20
        return stack
    }()
    
    private var imageFromLibrary: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "photo")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        //      image.isUserInteractionEnabled - добавляет возможность взаимодействовать с картинкой
        image.isUserInteractionEnabled = true
        image.tintColor = .white
        image.layer.cornerRadius = image.frame.height / 2.0
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
    
    //    Пробное сохранение
    private func creatItemProductEntity(item: ProfitModelItem){
        let product = ProductEntity(context: managerData.context)
        product.name = item.name
        product.priceProfit = Int32(item.priceProfit)
        product.priceGross = Int32(item.priceGross)
        product.image = item.image
        product.data = item.date
        managerData.save()
    }
    
    //    Сохранение данных для текущих значений
    private func creatItemCurrentData(item: ProfitModelItem){
        let product = CurrentDate(context: managerData.context)
        product.currentProfit = Int32(item.priceProfit)
        product.currentGross = Int32(item.priceGross)
        managerData.save()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
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
    //    Нажатие на картинку
    @objc private func didTapImageView(){
        alertPhotoOrCamera { [self] source in
            chooseImagePicker(source: source)
        }
    }
    
    //    Нажатие на дату
    @objc private func didTapDate(){
        alertDate(label: chooseDate) {[self] int , date in
            let format = DateFormatter()
            format.timeStyle = .none
            format.dateStyle = .long
            timeDate = format.string(from: date)
        }
    }
}



//MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension DetailVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func chooseImagePicker(source: UIImagePickerController.SourceType){
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
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
    //    Сохранить новый item
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
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hidenKayBoard)))
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowNotification(notification: )), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapImageView))
        imageFromLibrary.addGestureRecognizer(tapGestureRecognizer)
        
        let tapGestureDate = UITapGestureRecognizer(target: self, action: #selector(didTapDate))
        chooseDate.isUserInteractionEnabled = true
        chooseDate.addGestureRecognizer(tapGestureDate)
        
        imageFromLibrary.layer.masksToBounds = true
        imageFromLibrary.clipsToBounds = true
        imageFromLibrary.layer.cornerRadius = 20
        
        view.addViewWithoutTAMIC(labelTitleVC)
        view.addViewWithoutTAMIC(stack)
        view.addViewWithoutTAMIC(stackForImage)
        view.addViewWithoutTAMIC(imageFromLibrary)
        
        stackForImage.addArrangedSubview(buttonSafeImage)
        stackForImage.addArrangedSubview(buttonSafeAndMakingPhoto)
        
        stackForName.addArrangedSubview(nameLbl)
        stackForName.addArrangedSubview(chooseDate)
        
        stack.addArrangedSubview(stackForName)
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
            imageFromLibrary.widthAnchor.constraint(equalToConstant: 250),
            imageFromLibrary.heightAnchor.constraint(equalToConstant: 200),
            
            labelTitleVC.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor),
            labelTitleVC.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            labelTitleVC.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            labelTitleVC.bottomAnchor.constraint(equalTo: imageFromLibrary.topAnchor,constant:  -10),
            
            imageFromLibrary.topAnchor.constraint(equalTo: labelTitleVC.bottomAnchor,constant:  0),
            imageFromLibrary.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageFromLibrary.bottomAnchor.constraint(equalTo: stackForImage.topAnchor,constant: -20),
            
            buttonSafeImage.trailingAnchor.constraint(equalTo: imageFromLibrary.trailingAnchor, constant:  view.bounds.width * 0.14),
            buttonSafeAndMakingPhoto.trailingAnchor.constraint(equalTo: imageFromLibrary.trailingAnchor, constant:  view.bounds.width * 0.14),
            
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
            stack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:  -165),
            
            stackForButton.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 15),
            stackForButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            stackForButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            stackForButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:  -view.bounds.height / 9)
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

//MARK: - Move view after show/hide keyboard
extension DetailVC {
    
    @objc func hidenKayBoard(){
        self.view.endEditing(true)
    }
    
    @objc func keyboardWillShowNotification(notification: NSNotification){
        let info: NSDictionary = notification.userInfo! as NSDictionary
        let keyBoardSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyBeardY = self.view.frame.height - keyBoardSize.height
        let editingTextField = nameTextField.convert(nameTextField.bounds, to: self.view).minY;
        
        let screen = UIScreen.main.bounds.height / 3.3
        
        if self.view.frame.minY >= 0
        {
            if editingTextField > keyBeardY - screen
            {
                UIView.animate(withDuration: 0.25,
                               delay: 0.0,
                               options: UIView.AnimationOptions.curveEaseIn)
                {
                    self.view.frame = CGRect(
                        x: 0,
                        y:self.view.frame.origin.y-(editingTextField-keyBeardY + screen),
                        width: self.view.frame.width,
                        height: self.view.bounds.height)
                }
            }
        }
    }
    
    @objc func keyBoardWillHide(){
        UIView.animate(withDuration: 0.25,
                       delay: 0.0,
                       options: UIView.AnimationOptions.curveEaseIn)
        {
            self.view.frame = CGRect(
                x: 0,
                y: 0,
                width: self.view.frame.width,
                height: self.view.bounds.height)
        }
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
            AlertCheckInputText(title: "Введите данные")
            return
        } else if !textProfit.isInt {
            AlertCheckInputText(title: "Введите числа")
            return
        } else if !textGross.isInt {
            AlertCheckInputText(title: "Введите числа")
            return
        }
    
        print("MARK сохранаяем:- \(timeDate)")
        
        let newProduct = ProfitModelItem(name: textName,
                                         priceGross: Int(textGross)!,
                                         priceProfit: Int(textProfit)!,
                                         image: saveImage,
                                         date: timeDate
        )
        
        
        
        print("Создан новый товар: Имя - \(newProduct.name)")
        print("Cтоимость - \(newProduct.priceGross)")
        print("Cтоимость с наценкой - \(newProduct.priceProfit)")
        print("Картинка - \(String(describing: saveImage?.description))")
        print("Дата создания - \(timeDate)")
        
        
        if !(newProduct.name == "") {
            creatItemProductEntity(item: newProduct)
            creatItemCurrentData(item: newProduct)
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
        chooseDate.text = String("\(product.value(forKey: "data"))")
        
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
                                             image: saveImage,
                                             date: timeDate
            )
            
            
            
            print("Создан новый товар: Имя - \(newProduct.name)")
            print("стоимость - \(newProduct.priceGross)")
            print("стоимость с наценкой - \(newProduct.priceProfit)")
            print("Картинка изменина")
            
            creatItemProductEntity(item: newProduct)
            creatItemCurrentData(item: newProduct)
        }
    }
}


extension DetailVC: UITextFieldDelegate
{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        nameTextField = textField
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
