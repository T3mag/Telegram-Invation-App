//
//  Link+CoreDataProperties.swift
//  Telegram Invation App
//
//  Created by Артур Миннушин on 15.05.2025.
//
//

import Foundation
import CoreData


extension Link {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Link> {
        return NSFetchRequest<Link>(entityName: "Link")
    }

    @NSManaged public var countJoined: String?
    @NSManaged public var linkId: UUID?
    @NSManaged public var linkTitile: String?
    @NSManaged public var joinedPeoples: NSSet?

}

// MARK: Generated accessors for joinedPeoples
extension Link {

    @objc(addJoinedPeoplesObject:)
    @NSManaged public func addToJoinedPeoples(_ value: JoinedPeoples)

    @objc(removeJoinedPeoplesObject:)
    @NSManaged public func removeFromJoinedPeoples(_ value: JoinedPeoples)

    @objc(addJoinedPeoples:)
    @NSManaged public func addToJoinedPeoples(_ values: NSSet)

    @objc(removeJoinedPeoples:)
    @NSManaged public func removeFromJoinedPeoples(_ values: NSSet)

}

extension Link : Identifiable {

}
