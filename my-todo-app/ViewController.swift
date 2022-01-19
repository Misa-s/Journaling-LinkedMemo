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
    
    // UITableViewを継承するとこれ必須の模様, リスト -> cell のアクションなのかな
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let todoTitle = todoList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! MemoTableViewCell
        cell.memo.text = todoTitle
        return cell
    }

    // deletegeでモーダルから呼ばれる
    func addItem(text: String) {
        self.todoList.insert(text, at: 0)
        self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: UITableView.RowAnimation.right)
    }
    
    // 追加ボタン押下
    @IBSegueAction func openModalSegueAction(_ coder: NSCoder) -> AddModalViewController? {
        let modalView = AddModalViewController(coder: coder)
        modalView?.delegate = self
        return modalView
    }


}

