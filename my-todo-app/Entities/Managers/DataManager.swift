//
//  DataManager.swift
//  my-todo-app
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
    
    static func insert(entity: NSManagedObject){
        // TODO: 上手く動くのかしら
        let context = persistentContainer.viewContext
        context.insert(entity)
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
    
}



