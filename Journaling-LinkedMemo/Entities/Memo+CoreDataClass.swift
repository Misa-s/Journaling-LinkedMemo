//
//  Memo+CoreDataClass.swift
//  Journaling-LinkedMemo
//
//  Created by Misaki Shimazaki on 2022/01/26.
//
//

import Foundation
import CoreData


public class Memo: Tag {
    
    func getStrDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd' 'HH:mm"
        return formatter.string(from: self.datatime!)
    }

}
