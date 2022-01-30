//
//  Tag+CoreDataProperties.swift
//  Journaling-LinkedMemo
//
//  Created by Misaki Shimazaki on 2022/01/26.
//
//

import Foundation
import CoreData


extension Tag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tag> {
        return NSFetchRequest<Tag>(entityName: "Tag")
    }

    @NSManaged public var name: String?
    @NSManaged public var memos: NSSet?

}

// MARK: Generated accessors for memos
extension Tag {

    @objc(addMemosObject:)
    @NSManaged public func addToMemos(_ value: Memo)

    @objc(removeMemosObject:)
    @NSManaged public func removeFromMemos(_ value: Memo)

    @objc(addMemos:)
    @NSManaged public func addToMemos(_ values: NSSet)

    @objc(removeMemos:)
    @NSManaged public func removeFromMemos(_ values: NSSet)

}

extension Tag : Identifiable {

}
