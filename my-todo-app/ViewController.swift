//
//  ViewController.swift
//  my-todo-app
//
//  Created by Misaki Shimazaki on 2022/01/15.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PostDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var memoList = [String]()
    
    
    // イニシャライザー的なやつ
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // セルの幅がデバイスによって変わるので画面サイズに合わせる
        let screenRect = UIScreen.main.bounds
            tableView.frame = CGRect(x: 0, y: 0, width: screenRect.width, height: screenRect.height)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoList.count
    }
    
    // UITableViewを継承するとこれ必須の模様, セルの描画？
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let memoText = memoList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "memoListCell", for: indexPath)
        
        let MEMO = 1
        let DATA_TIME = 2
        
        // Cellのメモ
        let memoLabel = cell.viewWithTag(MEMO) as! UILabel
        memoLabel.text = memoText
        
        // Cellの投稿時間
        let dataTimeLabel = cell.viewWithTag(DATA_TIME) as! UILabel
        dataTimeLabel.text = getNowClockString()
       
        return cell
    }
    
    func getNowClockString() -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd' 'HH:mm"
            let now = Date()
            return formatter.string(from: now)
        }
    
    // セルの削除機能
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            memoList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    // セルがタップされた時の処理
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        tableView.deselectRow(at: indexPath, animated: true)
    //
    //        //　タップされたセルの取得
    //        let cell = self.tableView.cellForRow(at:indexPath) as! MemoTableViewCell
    //
    //        let storyboard: UIStoryboard = self.storyboard!
    //        let modalView = storyboard.instantiateViewController(withIdentifier: "modalView") as! AddModalViewController
    //        modalView.delegate = self
    //
    //        modalView.memo.text = cell.memo.text // modalのメモがnil、なぜ
    //        present(modalView, animated: true, completion: nil)
    //    }
    
    // deletegeでモーダルから呼ばれる
    func addItem(text: String) {
        self.memoList.insert(text, at: 0)
        self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: UITableView.RowAnimation.right)
    }
    
    // 新規追加モーダルの表示
    @IBAction func openAddModal(_ sender: Any) {
        let storyboard: UIStoryboard = self.storyboard!
        let modalView = storyboard.instantiateViewController(withIdentifier: "modalView") as! AddModalViewController
        modalView.delegate = self
        self.present(modalView, animated: true, completion: nil)
    }
}

