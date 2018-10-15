//
//  NeedsEntity+CoreDataProperties.swift
//  
//
//  Created by Steven Muliamin on 12/10/18.
//
//

import Foundation
import CoreData


extension NeedsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NeedsEntity> {
        return NSFetchRequest<NeedsEntity>(entityName: "NeedsEntity")
    }

    @NSManaged public var needsId: Int64
    @NSManaged public var needsName: String?

}
