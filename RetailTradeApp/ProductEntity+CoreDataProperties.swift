//
//  ProductEntity+CoreDataProperties.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 06.12.2022.
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
    @NSManaged public var image: Data?
    @NSManaged public var data: Date?

}

extension ProductEntity : Identifiable {

}
