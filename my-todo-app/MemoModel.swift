//
//  MemoModel.swift
//  my-todo-app
//
//  Created by Misaki Shimazaki on 2022/01/24.
//
import Foundation

struct MemoModel {
    var id:Int = -1
    var memoText:String = ""
    var date_time:Date = Date.now
    var nextMemos: [MemoModel] = []
    
    func getStrDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd' 'HH:mm"
        let now = Date()
        return formatter.string(from: now)
    }
}
