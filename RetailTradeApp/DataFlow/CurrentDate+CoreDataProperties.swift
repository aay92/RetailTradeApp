//
//  CurrentDate+CoreDataProperties.swift
//  RetailTradeApp
//
//  Created by Aleksey Alyonin on 25.02.2023.
//
//

import Foundation
import CoreData


extension CurrentDate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CurrentDate> {
        return NSFetchRequest<CurrentDate>(entityName: "CurrentDate")
    }

    @NSManaged public var currentAmount: Int32
    @NSManaged public var currentGross: Int32
    @NSManaged public var currentProfit: Int32
    @NSManaged public var date: Date?

}

extension CurrentDate : Identifiable {

}
