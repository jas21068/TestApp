//
//  SubMenuItem+CoreDataProperties.swift
//  TestApp
//
//  Created by Jaskirat Mangat on 2021-08-18.
//
//

import Foundation
import CoreData


extension SubMenuItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SubMenuItem> {
        return NSFetchRequest<SubMenuItem>(entityName: "SubMenuItem")
    }

    @NSManaged public var subname: String?
    @NSManaged public var price: String?
    @NSManaged public var about: String?
    @NSManaged public var imageData: Data?
    @NSManaged public var id: UUID?
   
    @NSManaged public var menuItem: MenuItem?
    

}

extension SubMenuItem : Identifiable {

}
