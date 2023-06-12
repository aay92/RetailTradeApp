//
//  ModelOverview+CoreDataClass.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 23.02.2023.
//
//

import Foundation
import CoreData


public class ModelOverview: NSManagedObject, Codable
{
    
    required convenience public init(from decoder: Decoder) throws {
        /// first we need to extract managed object context to initialise
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else { throw ContextError.NoContextFound }
        self.init(context: context)

        //        Decoding Item
        let value = try decoder.container(keyedBy: CodingKeys.self)
        data = try value.decode(Date.self, forKey: .data)
        nameMonth = try value.decode(String.self, forKey: .nameMonth)
        totalAmount = try value.decode(Int32.self, forKey: .totalAmount)
        totalProfit = try value.decode(Int32.self, forKey: .totalProfit)
        totalGross = try value.decode(Int32.self, forKey: .totalGross)

    }
    
    //    conforming encoding
    public func encode(to encoder: Encoder) throws {
        ///encoding item
        var values = encoder.container(keyedBy: CodingKeys.self)
        try values.encode(data, forKey: .data)
        try values.encode(nameMonth, forKey: .nameMonth)
        try values.encode(totalGross, forKey: .totalGross)
        try values.encode(totalProfit, forKey: .totalProfit)
        try values.encode(totalAmount, forKey: .totalAmount)
    }

    enum CodingKeys: CodingKey {
        case data, nameMonth, totalAmount, totalGross, totalProfit
    }
}
extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "managedObjectContext")!
}


