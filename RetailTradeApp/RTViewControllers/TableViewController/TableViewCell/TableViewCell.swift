//
//  TableViewCell.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 22.11.2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static let identifier = "TableViewCell"
    
    private let viewProfit: UIView = {
        let view = UIView()
        view.clipsToBounds = false
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
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
        label.font = UIFont(name: "Ariel", size: 15)
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var priceLbl: UILabel = {
        let label = UILabel()
        label.text = "Стоимость"
        label.font = UIFont(name: "Ariel", size: 15)
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        constraintViews()
        configureAppereance()
        
        addSubview(viewProfit)
        addSubview(stack)
        stack.addArrangedSubview(nameLbl)
        stack.addArrangedSubview(priceLbl)
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
     
    }
    
    func constraintViews(){
        NSLayoutConstraint.activate([
            
            
            viewProfit.topAnchor.constraint(equalTo: topAnchor),
            viewProfit.leadingAnchor.constraint(equalTo: leadingAnchor),
            viewProfit.trailingAnchor.constraint(equalTo: trailingAnchor),
            viewProfit.bottomAnchor.constraint(equalTo: bottomAnchor),


            stack.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 5),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5),
        ])
    }
    
    func configureAppereance(){
        viewProfit.backgroundColor = .red
    }

}
