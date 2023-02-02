//
//  ProfitModel.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 22.11.2022.
//

import UIKit

//MARK: - Model for creating item at trading
struct ProfitModelItem {
    var name: String
    var priceGross: Int
    var priceProfit: Int
    var image: Data?
    var date: String?
}


//MARK: - Model in collection view
struct ProfitItemInCollectionView {
    let name: String
    var sumGross: Int
    var sumProfit: Int
}
