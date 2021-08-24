//
//  SubMenuItem+CoreDataClass.swift
//  TestApp
//
//  Created by Jaskirat Mangat on 2021-08-18.
//
//

import Foundation
import CoreData
import UIKit

@objc(SubMenuItem)
public class SubMenuItem: NSManagedObject {
     private var optionalData = UIImage(systemName: "person.circle.fill")?.jpegData(compressionQuality: 1)
    public var wrappedSubName:String{
        subname ?? "Unknown Name"
    }
    
    public var wrappedSubPrice:String{
        price ?? "Unknown Name"
    }
    
    public var wrappedSubAbout:String{
        about ?? "Unknown Name"
    }
    
    public var wrappedSubImage:Data{
       
        imageData ?? optionalData!
    }

}

extension SubMenuItem: Comparable {
    public static func <(lhs: SubMenuItem, rhs: SubMenuItem) -> Bool {
        lhs.wrappedSubName > rhs.wrappedSubName
    }
}
