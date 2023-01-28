//
//  MonthTableViewCell.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 27.01.2023.
//

import UIKit

class MonthTableViewCell: UITableViewCell {
    
    static let identifier = "TableViewCell"
    
    
//    MARK: - property
    
    //    var nameMonth: String - Название месяца
    private let nameMonth: UILabel = {
        let label = UILabel()
        return label
    }()
    // var totalAmount: Int32   - Общая сумма гразыми
    private let totalAmount: UILabel = {
        let label = UILabel()
        return label
    }()
    private let totalAmountNumber: UILabel = {
        let label = UILabel()
        return label
    }()
    // var totalProfit: Int32 - Общая сумма чустой прибыли
    private let totalProfit: UILabel = {
        let label = UILabel()
        return label
    }()
    private let totalProfitNumber: UILabel = {
        let label = UILabel()
        return label
    }()
    // var totalGross: Int32 - costPrice - Себестоимость
    private let costPrice: UILabel = {
        let label = UILabel()
        return label
    }()
    private let costPriceNumber: UILabel = {
        let label = UILabel()
        return label
    }()

    
    //    MARK: - Stacks
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
    
     var lblData: UILabel = {
        let label = UILabel()
        label.text = "Дата"
        label.font = UIFont(name: "Ariel", size: 11)
        label.font = UIFont.boldSystemFont(ofSize: 11)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
//    private let stack: UIStackView = {
//        let stackView = UIStackView()
//        stackView.clipsToBounds = false
//        stackView.axis = .horizontal
//        stackView.distribution  = .fill
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.backgroundColor = .clear
//        stackView.spacing = 10
//        return stackView
//    }()
    
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
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with item: ProductEntity){
        nameLbl.text = item.name
        priceLblGross.text = String(item.priceGross) + " ₽"
        priceLblProfit.text = String(item.priceProfit) + " ₽"
        
        print("MARK в ячейке:- \(item.data)")
        lblData.text = item.data
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
     
        addSubview(viewDate)
        addSubview(lblData)
        addSubview(viewProfit)
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
    
    
    func constraintViews(){
        
        NSLayoutConstraint.activate([
            
            viewDate.topAnchor.constraint(equalTo: topAnchor),
            viewDate.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            viewDate.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            viewDate.bottomAnchor.constraint(equalTo: bottomAnchor, constant: frame.height / -10.5),
            
            
            lblData.topAnchor.constraint(equalTo: topAnchor),
            lblData.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            lblData.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            lblData.bottomAnchor.constraint(equalTo: viewProfit.topAnchor, constant: 0),
            
            
            viewProfit.topAnchor.constraint(equalTo: topAnchor, constant: 13),
            viewProfit.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            viewProfit.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            viewProfit.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            
            
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
