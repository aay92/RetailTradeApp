//
//  ProductEntity+CoreDataProperties.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 20.01.2023.
//
//

import Foundation
import CoreData


extension ProductEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductEntity> {
        return NSFetchRequest<ProductEntity>(entityName: "ProductEntity")
    }

    @NSManaged public var data: String?
    @NSManaged public var image: Data?
    @NSManaged public var name: String?
    @NSManaged public var priceGross: Int32
    @NSManaged public var priceProfit: Int32

}

extension ProductEntity : Identifiable {

}
