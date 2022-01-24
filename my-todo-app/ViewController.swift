//
//  ViewController.swift
//  my-todo-app
//
//  Created by Misaki Shimazaki on 2022/01/15.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddDelegate, EditDelegate {
    

    
    
    @IBOutlet weak var tableView: UITableView!
    var memoList = [Memo]()
    
    
    // イニシャライザー的なやつ
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        let memoModel = memoList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "memoListCell", for: indexPath)
        
        // IndexPathを持たせておく
        cell.tag = indexPath.row
        
        // Cellのメモ
        let memoLabel = cell.viewWithTag(MEMO) as! UILabel
        memoLabel.text = memoModel.memoText
        
        // Cellの投稿時間
        let dataTimeLabel = cell.viewWithTag(DATA_TIME) as! UILabel
        dataTimeLabel.text = memoModel.getStrDate()
        
        return cell
    }
    

    
    // セルの削除機能
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            memoList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    // 【新規追加】deletegeでモーダルから呼ばれる
    func addItem(memoModel: Memo) {
        self.memoList.insert(memoModel, at: 0)
        self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: UITableView.RowAnimation.right)
    }
    
    // 新規追加モーダルの表示
    @IBAction func openAddModal(_ sender: UIButton) {
        let storyboard: UIStoryboard = self.storyboard!
        let modalView = storyboard.instantiateViewController(withIdentifier: "modalView") as! MemoModalViewController
        modalView.addDelegate = self
        modalView.editDelegate = self
        modalView.mode = .add // TODO: initで渡したかったが断念、暫定
        self.present(modalView, animated: true, completion: nil)
    }
    
    
    // 【編集】deletegeでモーダルから呼ばれる
    func editItem(memoModel: Memo, index: Int) {
        // 対象のセルを取得
        let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: index))
        
        // Cellのメモ
        let memoLabel = cell?.viewWithTag(MEMO) as! UILabel
        memoLabel.text = memoModel.memoText
        
        // Cellの投稿時間
        let dataTimeLabel = cell?.viewWithTag(DATA_TIME) as! UILabel
        dataTimeLabel.text = memoModel.getStrDate()
    }
    
    // 編集モーダルの表示
    @IBAction func openEditModal(_ sender: UIButton) {
        let idx = sender.tag // TODO: セルの削除したら死ぬ気がする
        
        let storyboard: UIStoryboard = self.storyboard!
        let modalView = storyboard.instantiateViewController(withIdentifier: "modalView") as! MemoModalViewController
        modalView.addDelegate = self
        modalView.editDelegate = self
        modalView.mode = .edit
        modalView.index = idx
        modalView.memoModel = memoList[idx]
        
        self.present(modalView, animated: true, completion: nil)
    }
}

