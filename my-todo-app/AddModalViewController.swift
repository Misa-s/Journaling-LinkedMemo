//
//  AddModalViewController.swift
//  my-todo-app
//
//  Created by Misaki Shimazaki on 2022/01/15.
//

import UIKit

protocol PostDelegate: AnyObject {
    func addItem(text: String)
}

class AddModalViewController: UIViewController {
    
    @IBOutlet weak var memo: UITextView!

    weak var delegate: PostDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addButton(_ sender: Any) {
        // delegateを使って処理を委任
        delegate?.addItem(text: memo!.text)
        // モーダルを閉じる
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
