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
    
    private let viewDate: UIView = {
        let view = UIView()
        view.clipsToBounds = false
        //        view.backgroundColor = .systemGray
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var LblData: UILabel = {
        let label = UILabel()
        label.text = "Дата"
        label.font = UIFont(name: "Ariel", size: 11)
        label.font = UIFont.boldSystemFont(ofSize: 11)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let imageViewMain: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = false
        view.layer.cornerRadius = 10
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stack: UIStackView = {
        let stackView = UIStackView()
        stackView.clipsToBounds = false
        stackView.axis = .horizontal
        stackView.distribution  = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .clear
        stackView.spacing = 10
        return stackView
    }()
    
    private var nameLbl: UILabel = {
        let label = UILabel()
        label.text = "Название"
        label.font = UIFont(name: "Ariel", size: 15)
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let stackLblGross: UIStackView = {
        let stackView = UIStackView()
        stackView.clipsToBounds = false
        stackView.axis = .vertical
        stackView.distribution  = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    private var priceLblGross: UILabel = {
        let label = UILabel()
        label.text = "Стоимость"
        label.font = UIFont(name: "Ariel", size: 18)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var priceLblGrossDescription: UILabel = {
        let label = UILabel()
        label.text = "Стоимость с наценкой"
        label.font = UIFont(name: "Ariel", size: 13)
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .white.withAlphaComponent(0.6)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackLblProfit: UIStackView = {
        let stackView = UIStackView()
        stackView.clipsToBounds = false
        stackView.axis = .vertical
        stackView.distribution  = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    private var priceLblProfit: UILabel = {
        let label = UILabel()
        label.text = "Стоимость"
        label.font = UIFont(name: "Ariel", size: 18)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var priceLblProfitDescription: UILabel = {
        let label = UILabel()
        label.text = "Себeстоимость"
        label.font = UIFont(name: "Ariel", size: 13)
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .white.withAlphaComponent(0.6)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var priceLblData: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "Ariel", size: 10)
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textColor = .white.withAlphaComponent(0.6)
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
        
        
        
        addSubview(viewDate)
        addSubview(LblData)
        addSubview(viewProfit)
        addSubview(imageViewMain)
        addSubview(stack)
        stack.addArrangedSubview(nameLbl)
        stack.addArrangedSubview(stackLblGross)
        stack.addArrangedSubview(stackLblProfit)
        stackLblGross.addArrangedSubview(priceLblGross)
        stackLblGross.addArrangedSubview(priceLblGrossDescription)
        stackLblProfit.addArrangedSubview(priceLblProfit)
        stackLblProfit.addArrangedSubview(priceLblProfitDescription)
        
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
        guard let image = item.image else { return }
        imageViewMain.image = UIImage(data: image) ?? UIImage(systemName: "photo")
        
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        print("MARK:- \(item.data)")
        guard let realDate = item.data else { return }

        let dateString = dateFormatter.string(from: realDate)
        
        
        LblData.text = String("\(dateString)")
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func constraintViews(){
        NSLayoutConstraint.activate([
            
            viewDate.topAnchor.constraint(equalTo: topAnchor),
            viewDate.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            viewDate.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            viewDate.bottomAnchor.constraint(equalTo: bottomAnchor, constant: frame.height / -10.5),
            
            
            LblData.topAnchor.constraint(equalTo: topAnchor),
            LblData.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            LblData.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            LblData.bottomAnchor.constraint(equalTo: viewProfit.topAnchor, constant: 0),
            
            
            viewProfit.topAnchor.constraint(equalTo: topAnchor, constant: 13),
            viewProfit.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            viewProfit.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            viewProfit.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            
            imageViewMain.topAnchor.constraint(equalTo: stack.topAnchor, constant: 0),
            imageViewMain.leadingAnchor.constraint(equalTo: stack.trailingAnchor, constant: 10),
            imageViewMain.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            imageViewMain.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            stack.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -110),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
    }
    
    func configureAppereance(){
        
        backgroundColor = .clear
        stack.backgroundColor = .clear
        viewProfit.backgroundColor = R.Color.backgroundDetailVC
        
    }
    
}
