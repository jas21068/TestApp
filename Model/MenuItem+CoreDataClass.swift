//
//  MenuItem+CoreDataClass.swift
//  TestApp
//
//  Created by Jaskirat Mangat on 2021-08-18.
//
//

import Foundation
import CoreData

@objc(MenuItem)
public class MenuItem: NSManagedObject {
   
    
    public var wrappedName:String{
        name ?? "Unknown Name"
    }
    public var wrappedDesc:String{
        desc ?? "Unknown Description"
    }
    public var sunItemArray:[SubMenuItem]{
        
        let set = subItems as? Set<SubMenuItem> ?? []
        return set.sorted()
        
        
    }

}
