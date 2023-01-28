//
//  ModelOverview+CoreDataProperties.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 25.01.2023.
//
//

import Foundation
import CoreData


extension ModelOverview {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ModelOverview> {
        return NSFetchRequest<ModelOverview>(entityName: "ModelOverview")
    }

    @NSManaged public var data: String?
    @NSManaged public var totalAmount: Int32
    @NSManaged public var totalProfit: Int32
    @NSManaged public var totalGross: Int32
    @NSManaged public var nameMonth: String?

}

extension ModelOverview : Identifiable {

}
