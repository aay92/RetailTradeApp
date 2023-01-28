//
//  ViewTotalProfitSaveCell.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 23.01.2023.
//

import UIKit

class ViewTotalProfitSaveCell: UIView {
    
    enum Point {
        case topLeading
        case leading
        case bottomLeading
        case top
        case center
        case bottom
        case topTrailing
        case trailing
        case bottomTrailing

        var point: CGPoint {
            switch self {
            case .topLeading:
                return CGPoint(x: 0, y: 0)
            case .leading:
                return CGPoint(x: 0, y: 0.5)
            case .bottomLeading:
                return CGPoint(x: 0, y: 1.0)
            case .top:
                return CGPoint(x: 0.5, y: 0)
            case .center:
                return CGPoint(x: 0.5, y: 0.5)
            case .bottom:
                return CGPoint(x: 0.5, y: 1.0)
            case .topTrailing:
                return CGPoint(x: 1.0, y: 0.0)
            case .trailing:
                return CGPoint(x: 1.0, y: 0.5)
            case .bottomTrailing:
                return CGPoint(x: 1.0, y: 1.0)
            }
        }
    }
    
    private let gradientLayer = CAGradientLayer()

    
     var viewBackground: UIView = {
        let view = UIView()
        view.backgroundColor = R.Color.background
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        return view
    }()
    
    private let buttonTapped: UIButton = {
        let button = UIButton()
        button.setTitle("Сохранить месяц", for: .normal)
        button.titleLabel?.font = UIFont(name: "Ariel", size: 14)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.titleLabel?.numberOfLines = 0
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
        return button
    }()
    
    private let nameLbl: UILabel = {
        let button = UILabel()
        button.text = "Сохранить месяц"
        button.font = UIFont(name: "Ariel", size: 14)
        button.font = UIFont.boldSystemFont(ofSize: 14)
        button.numberOfLines = 0
        button.textColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
        
    }

    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient()
        
    }
    
    @objc func tappedButton(){
        print("tap")
        makeSystem(buttonTapped)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        buttonTapped.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
    }
    
    
    
    private func setupGradient() {
        self.layer.addSublayer(gradientLayer)
        setGradient(view: self, firstColors: R.Color.background, secondColor: .systemBlue, x: 0, y: 0, width: 120, height: 120)
        
    }

    private func setConstraints(){
        setupGradient()
    
        translatesAutoresizingMaskIntoConstraints = false
        layer.masksToBounds = true
        clipsToBounds = true
        
        addSubview(buttonTapped)
        NSLayoutConstraint.activate([
            buttonTapped.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            buttonTapped.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            buttonTapped.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            buttonTapped.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            
            ])
//        addSubview(viewBackground)
//        NSLayoutConstraint.activate([
//            viewBackground.topAnchor.constraint(equalTo: topAnchor, constant: 0),
//            viewBackground.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
//            viewBackground.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
//            viewBackground.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
//
//            ])
        
        
       
    }
    
}
