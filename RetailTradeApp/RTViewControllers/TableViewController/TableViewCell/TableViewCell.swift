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
    
    private let imageViewMain: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = false
        view.layer.cornerRadius = 10
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stack: UIStackView = {
        let stackView = UIStackView()
        stackView.clipsToBounds = false
        stackView.axis = .horizontal
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
    
    private var priceLblGross: UILabel = {
        let label = UILabel()
        label.text = "Стоимость"
        label.font = UIFont(name: "Ariel", size: 20)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var priceLblProfit: UILabel = {
        let label = UILabel()
        label.text = "Стоимость"
        label.font = UIFont(name: "Ariel", size: 20)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(viewProfit)
        addSubview(imageViewMain)
        addSubview(stack)
        stack.addArrangedSubview(nameLbl)
        stack.addArrangedSubview(priceLblGross)
        stack.addArrangedSubview(priceLblProfit)
        constraintViews()
        configureAppereance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with item: ProductEntity){
        nameLbl.text = item.name
        priceLblGross.text = String(item.priceGross) + " ₽"
        priceLblProfit.text = String(item.priceProfit) + " ₽"
//        guard let image = item.image else { return }
//        imageViewMain.image = UIImage(named: "\(image)")
    }
    
//    func configure(with item: ProfitModelItem){
//        nameLbl.text = item.name
//        priceLblGross.text = String(item.priceGross) + " ₽"
//        priceLblProfit.text = String(item.priceProfit) + " ₽"
//        guard let image = item.image else { return }
//        imageViewMain.image = UIImage(named: "\(image)")
//    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func constraintViews(){
        NSLayoutConstraint.activate([
            
            viewProfit.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            viewProfit.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            viewProfit.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            viewProfit.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),

            imageViewMain.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            imageViewMain.leadingAnchor.constraint(equalTo: stack.trailingAnchor, constant: -20),
            imageViewMain.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            imageViewMain.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            
            stack.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -90),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
        ])
    }
    
    func configureAppereance(){
        backgroundColor = .clear
        stack.backgroundColor = .clear
        viewProfit.backgroundColor = R.Color.backgroundDetailVC
    }

}
