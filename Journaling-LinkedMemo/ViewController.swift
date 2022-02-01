//
//  ViewController.swift
//  Journaling-LinkedMemo
//
//  Created by Misaki Shimazaki on 2022/01/15.
//

import UIKit
import CoreData
import FontAwesome_swift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddDelegate, EditDelegate, EditButtonDelegate {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    var memoList = DataManager.getMemos()
    
    
    /// イニシャライザー的なやつ
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let attributes = [NSAttributedString.Key.font: UIFont.fontAwesome(ofSize: 25, style: .solid), .foregroundColor : UIColor.white]
        menuButton.setTitleTextAttributes(attributes, for: .normal)
        menuButton.title = String.fontAwesomeIcon(name: .bars)
        
        // セルの幅がデバイスによって変わるので画面サイズに合わせる TODO: 横向きにしたとき
        let screenRect = UIScreen.main.bounds
        tableView.frame = CGRect(x: 0, y: 0, width: screenRect.width, height: screenRect.height)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoList.count
    }
    
    let MEMO = 1
    let DATA_TIME = 2
    // UITableViewを継承するとこれ必須の模様, セルの描画？
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let memo = memoList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "memoListCell", for: indexPath) as! MemoTableViewCell
        cell.delegate = self
        cell.memo = memo
        // Cellのメモ
        cell.memoLabel.text = memo.memo
        // Cellの投稿時間
        cell.datetimeLabel.text = memo.getStrDate()
        
        return cell
    }
    
    /// セルの削除機能
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            let memo = self.memoList[indexPath.row]
            DataManager.delete(entity: memo)
            memoList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
            self.tableView.reloadData()
        }
    }
    
    /// 【新規追加】deletegeでモーダルから呼ばれる
    func addCell(memo: Memo) {
        self.memoList.insert(memo, at: 0)
        self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: UITableView.RowAnimation.right)
    }
    
    /// 新規追加モーダルの表示
    @IBAction func openAddModal(_ sender: UIButton) {
        let storyboard: UIStoryboard = self.storyboard!
        let modalView = storyboard.instantiateViewController(withIdentifier: "modalView") as! MemoModalViewController
        
        modalView.addDelegate = self
        modalView.editDelegate = self
        modalView.mode = .add // TODO: initで渡したかったが断念、暫定
        
        self.present(modalView, animated: true, completion: nil)
    }
    
    
    /// 【編集】deletegeでモーダルから呼ばれる
    func editCell(memo: Memo, cell: MemoTableViewCell) {
        // TODO: ここでする必要あるのか？？？
        // Cellのメモ
        cell.memoLabel.text = memo.memo
        
        // Cellの投稿時間
        cell.datetimeLabel.text = memo.getStrDate()
    }
    
    ///
    func openEditModal(cell: MemoTableViewCell, memo: Memo) {
        let storyboard: UIStoryboard = self.storyboard!
        let modalView = storyboard.instantiateViewController(withIdentifier: "modalView") as! MemoModalViewController
        modalView.addDelegate = self
        modalView.editDelegate = self
        modalView.mode = .edit
        modalView.memoModel = memo
        modalView.targetCell = cell
        
        self.present(modalView, animated: true, completion: nil)
    }
    
}

