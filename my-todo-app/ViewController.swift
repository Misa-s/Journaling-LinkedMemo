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

    func addItem(text: String) {
        self.todoList.insert(text, at: 0)
        self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: UITableView.RowAnimation.right)
    }
    
    @IBAction func addButtonAction(_ sender: Any) {
        let alertController = UIAlertController(title: "TODO追加", message: "入力して下さい", preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField(configurationHandler: nil)
        
        let okAction = UIAlertAction(title: "追加", style: UIAlertAction.Style.default) { (acrion: UIAlertAction) in
            // 追加：OKをタップした時の処理
            if let textField = alertController.textFields?.first {
                self.todoList.insert(textField.text!, at: 0)
                self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: UITableView.RowAnimation.right)
            }
        }
        alertController.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "CANCEL", style: UIAlertAction.Style.cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated:true, completion: nil)
    }
    
    @IBSegueAction func openModalSegueAction(_ coder: NSCoder) -> AddModalViewController? {
        let modalView = AddModalViewController(coder: coder)
        modalView?.delegate = self
        return modalView
    }


}

