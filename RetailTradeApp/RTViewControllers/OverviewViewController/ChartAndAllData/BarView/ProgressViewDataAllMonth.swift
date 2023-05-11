//
//  ProgressViewDataAllMonth.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 25.04.2023.
//

import UIKit

final class ProgressViewDataAllMonth: BaseInfoView {

    private let barsView = BarsView()

    func configure(with itmes: [BarView]) {
        barsView.configure(with: itmes)
        
    }
//    func configure(with itmes: [BarView]) {
//        barsView.configure(with: itmes)
//        
//    }
    
//    func configure(with itmes: [BarView.Data]) {
//        barsView.configure(with: itmes)
//        
//    }
}

extension ProgressViewDataAllMonth {
    override func setupViews() {
        super.setupViews()
        addViewWithoutTAMIC(barsView)
    }
    override func constantViews() {
        super.constantViews()
  
        NSLayoutConstraint.activate([
            barsView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            barsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            barsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            barsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
        ])
    }

    override func configureAppearance() {
        super.configureAppearance()
        backgroundColor = .clear
//        self.layer.borderColor = UIColor.gray.withAlphaComponent(0.4).cgColor
//        self.layer.borderWidth = 10
//        self.layer.cornerRadius = 10
    }
}
