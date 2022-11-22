//
//  ProfitModel.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 22.11.2022.
//

import UIKit

//MARK: - Model for creating item at trading
struct ProfitModelItem {
    let name: String
    let price: Int
    let image: String?
}

//MARK: - Model in collection view
struct ProfitItemInCollectionView {
    let name: String
    let sum: Int
}
