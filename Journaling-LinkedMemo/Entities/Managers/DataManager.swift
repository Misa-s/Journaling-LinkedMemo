//
//  DataManager.swift
//  Journaling-LinkedMemo
//
//  Created by Misaki Shimazaki on 2022/01/27.
//

import Foundation
import UIKit
import CoreData

///  CoreDataのアクセスを担う
class DataManager: NSObject {
    
    private static var persistentContainer: NSPersistentCloudKitContainer! = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    static func newMemo() -> Memo { // 保存されていない
        let context = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Memo", in: context)!
        return  Memo(entity: entity, insertInto: nil)
    }
    
    static func newImage() -> Image { // 保存されていない
        let context = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Image", in: context)!
        return  Image(entity: entity, insertInto: nil)
    }
    
    static func getMemos() -> [Memo] {
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Memo")
        
        do {
            let memos = try context.fetch(request) as! [Memo]
            return memos
        }
        catch {
            fatalError()
        }
    }
    
    /// 保存
    static func save() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    static func delete(entity: NSManagedObject) {
        let context = persistentContainer.viewContext
        context.delete(entity)
        save()
    }
    
    static func insert(entity: NSManagedObject){
        let context = persistentContainer.viewContext
        context.insert(entity)
        save()
    }
    
}



