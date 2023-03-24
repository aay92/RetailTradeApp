//
//  CurrentDate+CoreDataClass.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 25.02.2023.
//
//

import Foundation
import CoreData

//@objc(CurrentDate)
public class CurrentDate: NSManagedObject, Codable {
    
    required convenience public init(from decoder: Decoder) throws {
        /// first we need to extract managed object context to initialise
        guard let context = decoder.userInfo[.context] as? NSManagedObjectContext else {
            throw ContextError.NoContextFound
        }
        self.init(context: context)
        
        //        Decoding Item
        let value = try decoder.container(keyedBy: CodingKeys.self)
        currentAmount = try value.decode(Int32.self, forKey: .currentAmount)
        currentGross = try value.decode(Int32.self, forKey: .currentGross)
        currentProfit = try value.decode(Int32.self, forKey: .currentProfit)
        date = try value.decode(Date.self, forKey: .date)
    }
    
    //    conforming encoding
    public func encode(to encoder: Encoder) throws {
        ///encoding item
        var values = encoder.container(keyedBy: CodingKeys.self)
        try values.encode(currentAmount, forKey: .currentAmount)
        try values.encode(currentGross, forKey: .currentGross)
        try values.encode(currentProfit, forKey: .currentProfit)
        try values.encode(date, forKey: .date)
    }
    
    enum CodingKeys: CodingKey {
        case currentAmount, currentGross, currentProfit, date
    }
}

//extension CodingUserInfoKey {
//    static let context = CodingUserInfoKey(rawValue: "managedObjectContext")!
//}
//
//enum ContextError: Error {
//    case NoContextFound
//}



