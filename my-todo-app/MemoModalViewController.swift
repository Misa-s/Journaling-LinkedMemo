//
//  AddModalViewController.swift
//  my-todo-app
//
//  Created by Misaki Shimazaki on 2022/01/15.
//

import UIKit

protocol AddDelegate: AnyObject {
    func addItem(memoModel: MemoModel)
}

protocol EditDelegate: AnyObject {
    func editItem(memoModel: MemoModel, index: Int)
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
    var memoModel: MemoModel = MemoModel.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memo.text = memoModel.memoText
    }
    
    @IBAction func postButton(_ sender: UIButton) {
        memoModel.memoText = memo!.text
        memoModel.date_time = Date.now
        
        if (self.mode == .add) {
            // 追加モード
            addDelegate?.addItem(memoModel: memoModel)
            dismiss(animated: true, completion: nil)
            return
        }
        
        // 編集モード
        editDelegate?.editItem(memoModel: memoModel, index: self.index)
        dismiss(animated: true, completion: nil)
    }

    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
