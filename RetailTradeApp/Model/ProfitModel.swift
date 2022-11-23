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

class DataFlow {
    
    private init(){}
    
  static func getData()-> [ProfitModelItem] {
        let itemProducts: [ProfitModelItem] = [
            .init(name: "AppleWatch", price: 20000, image: "gear"),
            .init(name: "Michell Kors", price: 4900, image: ""),
            .init(name: "Gucci", price: 1690, image: ""),
            .init(name: "Prado", price: 2590, image: ""),
        ]
        return itemProducts
    }
}

//MARK: - Model in collection view
struct ProfitItemInCollectionView {
    let name: String
    let sum: Int
}
