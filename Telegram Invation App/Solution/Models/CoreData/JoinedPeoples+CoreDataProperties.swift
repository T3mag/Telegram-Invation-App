//
//  JoinedPeoples+CoreDataProperties.swift
//  Telegram Invation App
//
//  Created by Артур Миннушин on 15.05.2025.
//
//

import Foundation
import CoreData


extension JoinedPeoples {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<JoinedPeoples> {
        return NSFetchRequest<JoinedPeoples>(entityName: "JoinedPeoples")
    }

    @NSManaged public var dateJoined: String?
    @NSManaged public var emojiPath: String?
    @NSManaged public var name: String?
    @NSManaged public var peopleId: UUID?
    @NSManaged public var photoPath: String?
    @NSManaged public var accentColorID: Int16
    @NSManaged public var link: Link?

}

extension JoinedPeoples : Identifiable {

}
