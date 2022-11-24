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
    @NSManaged public var priceGross: Int16
    @NSManaged public var priceProfit: Int16

}

extension ProductEntity : Identifiable {

}
