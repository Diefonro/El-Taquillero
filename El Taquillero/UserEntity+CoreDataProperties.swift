//
//  UserEntity+CoreDataProperties.swift
//  
//
//  Created by Andrés Fonseca on 11/11/2024.
//
//

import Foundation
import CoreData


extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var email: String?
    @NSManaged public var isLoggedn: Bool
    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var surname: String?

}
