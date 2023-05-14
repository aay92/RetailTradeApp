//
//  ChartsBars.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 25.04.2023.
//

import UIKit

final class BarsView: BaseView {

    private let stackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .fillEqually
       
        return view
    }()

    func configure(with data: [BarView]) {
        stackView.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        data.forEach {
            let barView = $0
            stackView.addArrangedSubview(barView)
            UIView.animate(withDuration: 0.4,
                           delay: 0,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 1) {
                barView.transform = CGAffineTransform(scaleX: 1.6, y: 1.6)
                barView.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }
    }
}

extension BarsView {
    override func setupViews() {
        super.setupViews()

        addViewWithoutTAMIC(stackView)
    }

    override func constantViews() {
        super.constantViews()
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    override func configureAppearance() {
        super.configureAppearance()
        backgroundColor = .clear
    }
}

