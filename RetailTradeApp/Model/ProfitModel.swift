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
    var image: String?
}

class DataFlow {
    
    private init(){}
    
  static func getData()-> [ProfitModelItem] {
        let itemProducts: [ProfitModelItem] = [
            .init(name: "AppleWatch", priceGross: 20000,priceProfit: 200, image: "gear"),
            .init(name: "Michell Kors", priceGross: 4900,priceProfit:1000, image: ""),
            .init(name: "Gucci", priceGross: 1690,priceProfit: 140, image: ""),
            .init(name: "Prado", priceGross: 2590,priceProfit: 450, image: ""),
        ]
        return itemProducts
    }
}

//MARK: - Model in collection view
struct ProfitItemInCollectionView {
    let name: String
    var sumGross: Int
    var sumProfit: Int
}
