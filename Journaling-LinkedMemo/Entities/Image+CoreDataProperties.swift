//
//  Image+CoreDataProperties.swift
//  Journaling-LinkedMemo
//
//  Created by Misaki Shimazaki on 2022/02/12.
//
//

import Foundation
import CoreData


extension Image {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Image> {
        return NSFetchRequest<Image>(entityName: "Image")
    }

    @NSManaged public var data: Data?
    @NSManaged public var relatedMemo: Memo?

}
