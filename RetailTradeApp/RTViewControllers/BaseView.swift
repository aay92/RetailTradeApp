//
//  BaseView.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 30.11.2022.
//
import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        constantViews()
        configureAppearance()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupViews()
        constantViews()
        configureAppearance()
    }
}

@objc extension BaseView {
    func setupViews() {}
    func constantViews() {}
    func configureAppearance() {
        backgroundColor = .white
    }
}

