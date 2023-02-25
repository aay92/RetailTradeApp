//
//  ModelOverview+CoreDataProperties.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 23.02.2023.
//
//

import Foundation
import CoreData


extension ModelOverview {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ModelOverview> {
        return NSFetchRequest<ModelOverview>(entityName: "ModelOverview")
    }

    @NSManaged public var data: Date?
    @NSManaged public var nameMonth: String?
    @NSManaged public var totalAmount: Int32
    @NSManaged public var totalGross: Int32
    @NSManaged public var totalProfit: Int32

}

extension ModelOverview : Identifiable {

}
