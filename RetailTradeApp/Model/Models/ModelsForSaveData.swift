//
//  ModelsForSaveData.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 11.06.2023.
//

import Foundation

// MARK: - CurrentDatum модель для сохранения данных на устройство
struct ObjectCurrentData: Codable {
    let date: JSONNull?
    let currentGross, currentAmount, currentProfit: Int?
}
typealias CurrentDataTypealias = [ObjectCurrentData]

// MARK: - CurrentDatumProductEntity модель для сохранения данных на устройство
struct ObjectProductEntity: Codable {
    let date: JSONNull?
    let data: String?
    let image: Data?
    let name: String?
    let priceGross, priceProfit: Int?
}
typealias ProductEntityTypealias = [ObjectProductEntity]

// MARK: - CurrentDatumProductEntity модель для сохранения данных на устройство
struct ObjectModelOverview: Codable {
    let data: JSONNull?
    let nameMonth: String?
    let totalAmount, totalGross, totalProfit: Int?
}
typealias ModelOverviewTypealias = [ObjectModelOverview]



// MARK: - Encode/decode helpers
class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool { return true }
    public var hashValue: Int { return 0 }
    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Ошибка в декодирование в модели JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
