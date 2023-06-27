//
//  RegisterUser+CoreDataProperties.swift
//  NewAudioPlayerProject
//
//  Created by NexG on 14/06/23.
//
//

import Foundation
import CoreData


extension RegisterUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RegisterUser> {
        return NSFetchRequest<RegisterUser>(entityName: "RegisterUser")
    }

    @NSManaged public var name: String?
    @NSManaged public var mobile: String?
    @NSManaged public var email: String?
    @NSManaged public var password: String?

}

extension RegisterUser : Identifiable {

}
