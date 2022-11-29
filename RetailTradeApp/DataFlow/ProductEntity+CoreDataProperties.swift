//
//  ProductEntity+CoreDataProperties.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 24.11.2022.
//
//

import Foundation
import CoreData


extension ProductEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductEntity> {
        return NSFetchRequest<ProductEntity>(entityName: "ProductEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var priceGross: Int32
    @NSManaged public var priceProfit: Int32

}

extension ProductEntity : Identifiable {

}
