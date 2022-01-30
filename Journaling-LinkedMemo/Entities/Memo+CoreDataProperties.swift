//
//  Memo+CoreDataProperties.swift
//  Journaling-LinkedMemo
//
//  Created by Misaki Shimazaki on 2022/01/26.
//
//

import Foundation
import CoreData


extension Memo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Memo> {
        return NSFetchRequest<Memo>(entityName: "Memo")
    }

    @NSManaged public var datatime: Date?
    @NSManaged public var image01: Data?
    @NSManaged public var image02: Data?
    @NSManaged public var image03: Data?
    @NSManaged public var image04: Data?
    @NSManaged public var image05: Data?
    @NSManaged public var image06: Data?
    @NSManaged public var memo: String?
    @NSManaged public var relatedMemos: NSSet?
    @NSManaged public var tags: NSSet?

}

// MARK: Generated accessors for relatedMemos
extension Memo {

    @objc(addRelatedMemosObject:)
    @NSManaged public func addToRelatedMemos(_ value: Memo)

    @objc(removeRelatedMemosObject:)
    @NSManaged public func removeFromRelatedMemos(_ value: Memo)

    @objc(addRelatedMemos:)
    @NSManaged public func addToRelatedMemos(_ values: NSSet)

    @objc(removeRelatedMemos:)
    @NSManaged public func removeFromRelatedMemos(_ values: NSSet)

}

// MARK: Generated accessors for tags
extension Memo {

    @objc(addTagsObject:)
    @NSManaged public func addToTags(_ value: Tag)

    @objc(removeTagsObject:)
    @NSManaged public func removeFromTags(_ value: Tag)

    @objc(addTags:)
    @NSManaged public func addToTags(_ values: NSSet)

    @objc(removeTags:)
    @NSManaged public func removeFromTags(_ values: NSSet)

}
