//
//  AddModalViewController.swift
//  my-todo-app
//
//  Created by Misaki Shimazaki on 2022/01/15.
//

import UIKit

protocol AddDelegate: AnyObject {
    func addItem(text: String)
}

protocol EditDelegate: AnyObject {
    func editItem(text: String, index: Int)
}

enum Mode {
    case add
    case edit
}

class MemoModalViewController: UIViewController {
    
    @IBOutlet weak var memo: UITextView!
    
    weak var addDelegate: AddDelegate?
    weak var editDelegate: EditDelegate?
    var mode: Mode = .add
    var index: Int = -1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func postButton(_ sender: UIButton) {
        if (self.mode == .add) {
            // 追加モード
            addDelegate?.addItem(text: memo!.text)
            dismiss(animated: true, completion: nil)
            return
        }
        
        // 編集モード
        editDelegate?.editItem(text: memo!.text, index: self.index)
        dismiss(animated: true, completion: nil)
    }

    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
