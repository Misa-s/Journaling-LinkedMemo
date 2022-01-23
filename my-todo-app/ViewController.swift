//
//  ViewController.swift
//  my-todo-app
//
//  Created by Misaki Shimazaki on 2022/01/15.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PostDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var todoList = [String]()
    
    
    // イニシャライザー的なやつ
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "MemoTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    // UITableViewを継承するとこれ必須の模様, セルの描画？
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let todoTitle = todoList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! MemoTableViewCell
        cell.memo.text = todoTitle
        return cell
    }
    
    // セルがタップされた時の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //　タップされたセルの取得
        let cell = self.tableView.cellForRow(at:indexPath) as! MemoTableViewCell
        
        let modalView = AddModalViewController()
        modalView.modalPresentationStyle = .formSheet
        modalView.delegate = self
        
        modalView.memo.text = cell.memo.text // modalのメモがnil、なぜ
        present(modalView, animated: true, completion: nil)
    }
    
    // deletegeでモーダルから呼ばれる
    func addItem(text: String) {
        self.todoList.insert(text, at: 0)
        self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: UITableView.RowAnimation.right)
    }
    
    @IBAction func openAddModal(_ sender: Any) {
        let storyboard: UIStoryboard = self.storyboard!
        let modalView = storyboard.instantiateViewController(withIdentifier: "modalView") as! AddModalViewController
        modalView.delegate = self
        self.present(modalView, animated: true, completion: nil)
    }
    //    // 追加ボタン押下
    //    @IBSegueAction func openModalSegueAction(_ coder: NSCoder) -> AddModalViewController? {
    //        let modalView = AddModalViewController(coder: coder)
    //        modalView?.delegate = self
    //        return modalView
    //    }
}

