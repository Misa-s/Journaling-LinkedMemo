//
//  Memo+CoreDataProperties.swift
//  Journaling-LinkedMemo
//
//  Created by Misaki Shimazaki on 2022/02/18.
//
//

import Foundation
import CoreData


extension Memo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Memo> {
        return NSFetchRequest<Memo>(entityName: "Memo")
    }

    @NSManaged public var datatime: Date?
    @NSManaged public var memo: String?
    @NSManaged public var images: NSSet?
    @NSManaged public var relatedMemos: NSSet?
    @NSManaged public var tags: NSSet?

}

// MARK: Generated accessors for images
extension Memo {

    @objc(insertObject:inImagesAtIndex:)
    @NSManaged public func insertIntoImages(_ value: Image, at idx: Int)

    @objc(removeObjectFromImagesAtIndex:)
    @NSManaged public func removeFromImages(at idx: Int)

    @objc(insertImages:atIndexes:)
    @NSManaged public func insertIntoImages(_ values: [Image], at indexes: NSIndexSet)

    @objc(removeImagesAtIndexes:)
    @NSManaged public func removeFromImages(at indexes: NSIndexSet)

    @objc(replaceObjectInImagesAtIndex:withObject:)
    @NSManaged public func replaceImages(at idx: Int, with value: Image)

    @objc(replaceImagesAtIndexes:withImages:)
    @NSManaged public func replaceImages(at indexes: NSIndexSet, with values: [Image])

    @objc(addImagesObject:)
    @NSManaged public func addToImages(_ value: Image)

    @objc(removeImagesObject:)
    @NSManaged public func removeFromImages(_ value: Image)

    @objc(addImages:)
    @NSManaged public func addToImages(_ values: NSOrderedSet)

    @objc(removeImages:)
    @NSManaged public func removeFromImages(_ values: NSOrderedSet)

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

extension Memo : Identifiable {

}
