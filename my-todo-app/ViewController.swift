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
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoList.count
    }
    
    // UITableViewを継承するとこれ必須の模様, セルの描画？
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let memoText = memoList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "memoListCell", for: indexPath)
        cell.textLabel?.text = memoText
        return cell
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

