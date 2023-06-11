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

//MARK: - Model in allData in months
struct itemModelOverview {
    let nameMonth: String?
    var totalAmount: Int32
    var totalProfit: Int32
    var totalGross: Int32
    var data: Date?
}

// MARK: - CurrentDatum
struct CurrentDatum: Codable {
    let date: JSONNull?
    let currentGross, currentAmount, currentProfit: Int?
}

typealias CurrentData = [CurrentDatum]

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
