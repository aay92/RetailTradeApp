//
//  BaseViewInfo.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 25.04.2023.
//

import UIKit

class BaseInfoView: BaseView {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = R.Fonts.helvelticaRegular(with: 13)
        label.textColor = UIColor.white
        return label
    }()

    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor.blue.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 5
        return view
    }()

    init(with title: String? = nil, buttonTitle: String? = nil) {
        titleLabel.text = title?.uppercased()
        titleLabel.textAlignment = buttonTitle == nil ? .center : .left
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        super.init(frame: .zero)
    }

}

extension BaseInfoView {
    override func setupViews() {
        super.setupViews()
        addViewWithoutTAMIC(titleLabel)
        addViewWithoutTAMIC(contentView)
    }
    override func constantViews() {
        super.constantViews()
  
        let contentTopAnchor: NSLayoutAnchor = titleLabel.text == nil ? topAnchor : titleLabel.bottomAnchor
        let contentTopOffset: CGFloat = titleLabel.text == nil ? 0 : 10

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            contentView.topAnchor.constraint(equalTo: contentTopAnchor, constant: contentTopOffset),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    override func configureAppearance() {
        super.configureAppearance()
        backgroundColor = .clear
    }
}
