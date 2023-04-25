//
//  ChartAndAllData.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 31.01.2023.
//

import UIKit

class ChartAndAllData: BaseView {
    
    static let identifier = "ChartAndAllData"

    private let chartsView: UIView = {
        let chartsView = UIView()
//        chartsView.backgroundColor = .blue.withAlphaComponent(0.4)
        chartsView.layer.borderColor = UIColor.gray.withAlphaComponent(0.4).cgColor
        chartsView.layer.borderWidth = 4
        chartsView.layer.masksToBounds = true
        chartsView.layer.cornerRadius = 20
        chartsView.translatesAutoresizingMaskIntoConstraints = false
        return chartsView
    }()
    
    private let viewProfit: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()
    
    // var totalAmount: Int32   - Общая сумма гразыми
    private let totalAmount: UILabel = {
        let label = UILabel()
        label.text = "Прибыль"
        label.font = UIFont(name: "Ariel", size: 12)
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .white.withAlphaComponent(0.7)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    private let totalAmountNumber: UILabel = {
        let label = UILabel()
        label.text = "54 000 р"
        label.font = UIFont(name: "Ariel", size: 16)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    // var totalProfit: Int32 - Общая сумма чустой прибыли
    private let totalProfit: UILabel = {
        let label = UILabel()
        label.text = "Доход"
        label.font = UIFont(name: "Ariel", size: 12)
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .white.withAlphaComponent(0.7)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    private let totalProfitNumber: UILabel = {
        let label = UILabel()
        label.text = "21 000 р"
        label.font = UIFont(name: "Ariel", size: 16)
        label.font = UIFont.boldSystemFont(ofSize: 16)
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
        label.font = UIFont(name: "Ariel", size: 12)
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .white.withAlphaComponent(0.7)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    private let costPriceNumber: UILabel = {
        let label = UILabel()
        label.text = "1200 р"
        label.font = UIFont(name: "Ariel", size: 16)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
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
        stackView.backgroundColor = .white.withAlphaComponent(0.14)
        stackView.layer.borderColor = UIColor.black.cgColor
        stackView.layer.borderWidth = 2
        stackView.layer.cornerRadius = 15
        stackView.spacing = 0
        return stackView
    }()
    
    //    Стек общая прибыль
    private let stackTotalAmount: UIStackView = {
        let stackView = UIStackView()
        stackView.clipsToBounds = false
        stackView.axis = .vertical
        stackView.distribution  = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.backgroundColor = .white.withAlphaComponent(0.2)
        stackView.layer.cornerRadius = 20

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
//        stackView.backgroundColor = .white.withAlphaComponent(0.2)
        stackView.layer.cornerRadius = 20
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
//        stackView.backgroundColor = .white.withAlphaComponent(0.2)
        stackView.layer.cornerRadius = 20
        return stackView
    }()
    
    func configure(with Profit : Int, Amount : Int, costPrice : Int){
        totalProfitNumber.text = String(Profit) + " ₽"
        totalAmountNumber.text = String(Amount) + " ₽"
        costPriceNumber.text = String(costPrice) + " ₽"
    }
   
    
    override func setupViews() {
        super.setupViews()
        viewProfit.layer.masksToBounds = true
        viewProfit.clipsToBounds = true
        viewProfit.layer.cornerRadius = 20
        
        addSubview(chartsView)
        addSubview(viewProfit)
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
    }
    
    override func constantViews() {
        super.constantViews()
        
        let height = UIScreen.main.bounds.size.height
        let width = UIScreen.main.bounds.size.width
        
//        500
        let x = (UIScreen.main.bounds.size.height / 100) + 4
        let y = (UIScreen.main.bounds.size.width / 100) + 5

        
        chartsView.frame = CGRect(x: x, y: y, width: width / 1.2, height: height / 3.4)

        NSLayoutConstraint.activate([
                
            chartsView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            chartsView.bottomAnchor.constraint(equalTo: stackMain.topAnchor,constant: -20),
            chartsView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            chartsView.trailingAnchor.constraint(equalTo: trailingAnchor, constant:  -5),
            
            
            viewProfit.topAnchor.constraint(equalTo: chartsView.bottomAnchor, constant: 5),
            viewProfit.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -5),
            viewProfit.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            viewProfit.trailingAnchor.constraint(equalTo: trailingAnchor, constant:  -5),
        
            
            stackMain.topAnchor.constraint(equalTo: chartsView.bottomAnchor,constant: 0),
            stackMain.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            stackMain.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -15),
            stackMain.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -5),
            
            stackTotalProfit.leadingAnchor.constraint(equalTo: leadingAnchor, constant: height / 30),
            stackCostPrice.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -height / 30),
            
            stackTotalProfit.topAnchor.constraint(equalTo: stackMain.topAnchor,constant: 2),
            totalProfitNumber.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -8),
//
            stackTotalAmount.topAnchor.constraint(equalTo: stackMain.topAnchor,constant: 2),
            totalAmountNumber.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -8),
//
            stackCostPrice.topAnchor.constraint(equalTo: stackMain.topAnchor,constant: 2),
            costPriceNumber.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -8),
        ])
    }
    override func configureAppearance() {
        super.configureAppearance()
        backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        
        newRect(value: 20,
                location: 1,
                firstColor: UIColor.white.withAlphaComponent(0.1),
                secondColor: UIColor.systemBlue.withAlphaComponent(0.3))
        
        newRect(value: 50,
                location: 2,
                firstColor: UIColor.white.withAlphaComponent(0.1),
                secondColor: UIColor.systemBlue.withAlphaComponent(0.3))
        
        newRect(value: 90,
                location: 3,
                firstColor: UIColor.white.withAlphaComponent(0.1),
                secondColor: UIColor.systemBlue.withAlphaComponent(0.3))
        
        newRect(value: 60,
                location: 4,
                firstColor: UIColor.white.withAlphaComponent(0.1),
                secondColor: UIColor.systemBlue.withAlphaComponent(0.3))
        
        
        
        
    }

    private func newRect(value: Int,location: Int, firstColor: UIColor, secondColor: UIColor){

        let downPoint: CGPoint = CGPoint(x: bounds.width / CGFloat((13 / location)), y: bounds.height / 1.29)
        let polygonPath = UIBezierPath()
        polygonPath.move(to: downPoint)

        polygonPath.addLine(to: CGPoint(x: downPoint.x, y: downPoint.y - CGFloat(value)))
        polygonPath.close()
        
        
        let firstColor = firstColor
        let secondColor = secondColor
        firstColor.setFill()
        secondColor.setStroke()
        polygonPath.fill()
        polygonPath.lineWidth = 15
        polygonPath.stroke()
    }
}
