//
//  MenuItem+CoreDataProperties.swift
//  TestApp
//
//  Created by Jaskirat Mangat on 2021-08-18.
//
//

import Foundation
import CoreData


extension MenuItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MenuItem> {
        return NSFetchRequest<MenuItem>(entityName: "MenuItem")
    }

    @NSManaged public var name: String?
    @NSManaged public var desc: String?
    @NSManaged public var id: UUID?
    @NSManaged public var imageData: Data?
    @NSManaged public var subItems: NSSet?
    
   
   
   

}

// MARK: Generated accessors for subItems
extension MenuItem {

    @objc(addSubItemsObject:)
    @NSManaged public func addToSubItems(_ value: SubMenuItem)

    @objc(removeSubItemsObject:)
    @NSManaged public func removeFromSubItems(_ value: SubMenuItem)

    @objc(addSubItems:)
    @NSManaged public func addToSubItems(_ values: NSSet)

    @objc(removeSubItems:)
    @NSManaged public func removeFromSubItems(_ values: NSSet)

}

extension MenuItem : Identifiable {

}
