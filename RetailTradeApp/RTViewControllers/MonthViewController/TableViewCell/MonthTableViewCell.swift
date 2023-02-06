//
//  MonthTableViewCell.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 27.01.2023.
//

import UIKit

class MonthTableViewCell: UITableViewCell {
    
    static let identifier = "MonthTableViewCell"
    
    
//    MARK: - property
    
    //    Фон ячейки
    private let viewBackground: UIView = {
        let label = UILabel()
        label.backgroundColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.backgroundColor = .systemBlue.withAlphaComponent(0.2)
        return label
    }()
    
    //    Дата
    //    var nameMonth: String - Название месяца
    private let nameMonth: UILabel = {
        let label = UILabel()
        label.text = "29 января 2023"
        label.font = UIFont(name: "Ariel", size: 11)
        label.font = UIFont.boldSystemFont(ofSize: 11)
        label.textColor = .white.withAlphaComponent(0.7)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.backgroundColor = .clear
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // var totalAmount: Int32   - Общая сумма гразыми
    private let totalAmount: UILabel = {
        let label = UILabel()
        label.text = "Общая прибыль"
        label.font = UIFont(name: "Ariel", size: 13)
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .white.withAlphaComponent(0.9)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    private let totalAmountNumber: UILabel = {
        let label = UILabel()
        label.text = "54 000 руб"
        label.font = UIFont(name: "Ariel", size: 20)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    // var totalProfit: Int32 - Общая сумма чустой прибыли
    private let totalProfit: UILabel = {
        let label = UILabel()
        label.text = "Чистый доход"
        label.font = UIFont(name: "Ariel", size: 15)
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    private let totalProfitNumber: UILabel = {
        let label = UILabel()
        label.text = "21 000 руб"
        label.font = UIFont(name: "Ariel", size: 20)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    // var totalGross: Int32 - costPrice - Себестоимость
    private let costPrice: UILabel = {
        let label = UILabel()
        label.text = "Себестоимость"
        label.font = UIFont(name: "Ariel", size: 13)
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .white.withAlphaComponent(0.9)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    private let costPriceNumber: UILabel = {
        let label = UILabel()
        label.text = "1200 руб"
        label.font = UIFont(name: "Ariel", size: 20)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    
    //    MARK: - Stacks
//    Главный стек
    private let stackMain: UIStackView = {
        let stackView = UIStackView()
        stackView.clipsToBounds = false
        stackView.axis = .horizontal
        stackView.distribution  = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .clear
        stackView.spacing = 10
        return stackView
    }()
    
    //    Стек общая прибыль
    private let stackTotalAmount: UIStackView = {
        let stackView = UIStackView()
        stackView.clipsToBounds = false
        stackView.axis = .vertical
        stackView.distribution  = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    //    Стек общий доход
    private let stackTotalProfit: UIStackView = {
        let stackView = UIStackView()
        stackView.clipsToBounds = false
        stackView.axis = .vertical
        stackView.distribution  = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    //    Стек общая сумма по себестоимости
    private let stackCostPrice: UIStackView = {
        let stackView = UIStackView()
        stackView.clipsToBounds = false
        stackView.axis = .vertical
        stackView.distribution  = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .clear
        return stackView
    }()

   
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")

    }
//
    func configure(with item: ModelOverview){
        totalProfitNumber.text = String(item.totalProfit) + " ₽"
        totalAmountNumber.text = String(item.totalGross) + " ₽"
        costPriceNumber.text = String(item.totalAmount) + " ₽"

        print("MARK в ячейке:- \(item.data)")
        nameMonth.text = item.data

    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        
        addSubview(nameMonth)
        addSubview(viewBackground)
        addSubview(stackMain)
      
        stackMain.addArrangedSubview(stackTotalProfit)
        stackMain.addArrangedSubview(stackTotalAmount)
        stackMain.addArrangedSubview(stackCostPrice)
        
        stackTotalProfit.addArrangedSubview(totalProfit)
        stackTotalProfit.addArrangedSubview(totalProfitNumber)
        
        stackTotalAmount.addArrangedSubview(totalAmount)
        stackTotalAmount.addArrangedSubview(totalAmountNumber)
        
        stackCostPrice.addArrangedSubview(costPrice)
        stackCostPrice.addArrangedSubview(costPriceNumber)
        
        constraintViews()
        configureAppereance()
    }
    
    
    func constraintViews(){
        
        NSLayoutConstraint.activate([
            
            nameMonth.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            nameMonth.bottomAnchor.constraint(equalTo: viewBackground.topAnchor,constant: 0),
            nameMonth.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            nameMonth.trailingAnchor.constraint(equalTo: trailingAnchor, constant:  -5),
            
            viewBackground.topAnchor.constraint(equalTo: nameMonth.bottomAnchor, constant: -5),
            viewBackground.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -5),
            viewBackground.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            viewBackground.trailingAnchor.constraint(equalTo: trailingAnchor, constant:  -5),
            
            stackMain.topAnchor.constraint(equalTo: nameMonth.bottomAnchor),
            stackMain.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            stackMain.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10),
            stackMain.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            stackTotalProfit.topAnchor.constraint(equalTo: stackMain.topAnchor,constant: 5),
            stackTotalProfit.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -10),
            
            stackTotalAmount.topAnchor.constraint(equalTo: stackMain.topAnchor,constant: 5),
            stackTotalAmount.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -10),

            stackCostPrice.topAnchor.constraint(equalTo: stackMain.topAnchor,constant: 5),
            stackCostPrice.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -10),

            ])
            
    }
    
    func configureAppereance(){
        
        backgroundColor = .clear
        stackMain.backgroundColor = .clear
        nameMonth.layer.cornerRadius = self.bounds.size.height / 5
        viewBackground.layer.cornerRadius = self.bounds.size.height / 5
 
//        viewProfit.backgroundColor = R.Color.backgroundDetailVC
        
    }
    
}
