//
//  ViewTotalProfit.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 30.11.2022.
//

import UIKit

class ViewTotalProfit: BaseView {
    
    static let identifier = "ViewTotalProfit"
    
    var endValue: Double = 0
    var startValue: Double = 0
    let animationDurration = 1.0
    let animationStartData = Date()
    
    private let viewProfit: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemRed
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
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
        label.text = "Чистая прибыль"
        label.font = UIFont(name: "Ariel", size: 25)
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .white.withAlphaComponent(0.8)
        label.textAlignment = .natural
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var priceLbl: UILabel = {
        let label = UILabel()
        label.text = "2 450"
        label.font = UIFont(name: "Ariel", size: 35)
       
        label.font = UIFont.boldSystemFont(ofSize: 35)
        label.textColor = .white
        label.textAlignment = .natural
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func configure(num: Int){
        endValue = Double(num)
        priceLbl.text = String(endValue)
    }
    
    @objc func handlerRunLoopMode(){
       
        let now = Date()
        
        let elapsedTime = now.timeIntervalSince(animationStartData)
        if elapsedTime > animationDurration {
            self.priceLbl.text = String(format: "%.0f", endValue)
        } else {
            let percenteg = elapsedTime / animationDurration
            let value = startValue + percenteg * (endValue - startValue)
            self.priceLbl.text = String(format: "%.0f", value)
        }
        
    }
        
    override func setupViews() {
        super.setupViews()
        addSubview(viewProfit)
        addSubview(stack)
        stack.addArrangedSubview(nameLbl)
        stack.addArrangedSubview(priceLbl)
    }
    
    override func constantViews() {
        super.constantViews()

        let height = UIScreen.main.bounds.size.height
        let width = UIScreen.main.bounds.size.width
        
        NSLayoutConstraint.activate([
            viewProfit.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            viewProfit.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            viewProfit.trailingAnchor.constraint(equalTo:trailingAnchor, constant:  height / -150),
            viewProfit.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),

            stack.topAnchor.constraint(equalTo: topAnchor, constant:15),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
        ])
    }
    override func configureAppearance() {
        super.configureAppearance()

        backgroundColor = .clear

        let displayLink = CADisplayLink(target: self, selector: #selector(handlerRunLoopMode))
        displayLink.add(to: .main, forMode: .default)
    }
}


