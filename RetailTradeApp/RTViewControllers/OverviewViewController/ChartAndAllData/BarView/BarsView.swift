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

    func configure(with data: [BarView.Data]) {
        data.forEach {
            let barView = BarView(data: $0)
            stackView.addArrangedSubview(barView)
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

