//
//  ProductEntity+CoreDataClass.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 25.01.2023.
//
//

import Foundation
import CoreData

//@objc(ProductEntity)
public class ProductEntity: NSManagedObject {
    
//    required convenience public init(from decoder: Decoder) throws {
//        /// first we need to extract managed object context to initialise
//        guard let context = decoder.userInfo[.context] as? NSManagedObjectContext else {
//            throw ContextError.NoContextFound
//        }
//        self.init(context: context)
//
//        //        Decoding Item
//        let value = try decoder.container(keyedBy: CodingKeys.self)
//        data = try value.decode(String.self, forKey: .data)
//        image = try value.decode(Data.self, forKey: .image)
//        name = try value.decode(String.self, forKey: .name)
//        priceGross = try value.decode(Int32.self, forKey: .priceGross)
//        priceProfit = try value.decode(Int32.self, forKey: .priceProfit)
//
//    }
//    //    conforming encoding
//    public func encode(to encoder: Encoder) throws {
//        ///encoding item
//        var values = encoder.container(keyedBy: CodingKeys.self)
//        try values.encode(data, forKey: .data)
//        try values.encode(image, forKey: .image)
//        try values.encode(name, forKey: .name)
//        try values.encode(priceGross, forKey: .priceGross)
//        try values.encode(priceProfit, forKey: .priceProfit)
//
//    }
//
//    enum CodingKeys: CodingKey {
//        case data, image, name, priceGross, priceProfit
//    }
}
//extension CodingUserInfoKey {
//    static let context = CodingUserInfoKey(rawValue: "managedObjectContext")!
//}
//
//enum ContextError: Error {
//    case NoContextFound
//}


