//
//  ProfitCell.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 22.11.2022.
//

import UIKit

class ProfitCell: UICollectionViewCell {
    
    static let identifier = "ProfitCell"
    
    private let viewProfit: UIView = {
        let view = UIView()
        view.clipsToBounds = false
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .white
        return view
    }()
    
    private let stack: UIStackView = {
        let stackView = UIStackView()
        stackView.clipsToBounds = false
        stackView.axis = .vertical
        stackView.distribution  = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    
    private var nameLbl: UILabel = {
        let label = UILabel()
        label.text = "Название"
        label.font = UIFont(name: "Ariel", size: 20)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white.withAlphaComponent(0.8)
        label.textAlignment = .natural
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var priceLbl: UILabel = {
        let label = UILabel()
        label.text = "Стоимость"
        label.font = UIFont(name: "Ariel", size: 30)
       
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .white
        label.textAlignment = .natural
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
//
//    private var image: UIImageView = {
//        let image = UIImageView()
//        image.contentMode = .scaleAspectFit
//        image.backgroundColor = .systemBlue.withAlphaComponent(0.3)
//        image.layer.cornerRadius = 10
//        image.image = UIImage(named: "")
//        image.translatesAutoresizingMaskIntoConstraints = false
//        return image
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
        setConsrtaints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setView(){
        layer.cornerRadius = 10
        viewProfit.backgroundColor = R.Color.active
//        layer.shadowOpacity = 0.7
//        layer.shadowOffset = .zero
//        layer.shadowRadius = 5
        addSubview(viewProfit)
        addSubview(stack)
        stack.addArrangedSubview(nameLbl)
        stack.addArrangedSubview(priceLbl)
    }
    
    
    func setUp(category: ProfitItemInCollectionView){
        
        if category.name == "Pribl" {
            nameLbl.text = "Общая прибыль"
            priceLbl.text = String("\(category.sumGross) ₽")
            
        } else {
            nameLbl.text = "Себестоимость"
            priceLbl.text = String("\(category.sumProfit) ₽")
        }
//        image.image = UIImage(named: "\(String(describing: category.image))")
//        categoryImageView.kf.setImage(with: category.image?.asUrl)
    }
    
    private func setConsrtaints(){
            NSLayoutConstraint.activate([
                viewProfit.topAnchor.constraint(equalTo: topAnchor, constant: 0),
                viewProfit.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
                viewProfit.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
                viewProfit.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            
                stack.topAnchor.constraint(equalTo: topAnchor, constant: 27),
                stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -27)
            ])
    }
    
}


