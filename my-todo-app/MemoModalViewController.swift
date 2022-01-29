//
//  AddModalViewController.swift
//  my-todo-app
//
//  Created by Misaki Shimazaki on 2022/01/15.
//

import UIKit

protocol AddDelegate: AnyObject {
    func addCell(memo: Memo)
}

protocol EditDelegate: AnyObject {
    func editCell(memo: Memo, cell: MemoTableViewCell)
}

enum Mode {
    case add
    case edit
}

/// メモの追加・編集用のモーダル
class MemoModalViewController: UIViewController {
    
    @IBOutlet weak var memo: UITextView!
    
    weak var addDelegate: AddDelegate?
    weak var editDelegate: EditDelegate?
    var mode: Mode = .add
    var index: Int = -1
    var memoModel: Memo =  DataManager.newMemo() // TODO: initへ
    var targetCell: MemoTableViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenRect = UIScreen.main.bounds
        memo.frame = CGRect(x: 0, y: 80, width: screenRect.width, height: screenRect.height)
        memo.text = memoModel.memo
        
        let bar = UIToolbar()
        let reset = UIBarButtonItem(image: UIImage(systemName: "photo"), style: .plain, target: self, action: #selector(test))
        bar.items = [reset]
        bar.sizeToFit()
        memo.inputAccessoryView = bar
    }
    
    @IBAction func postButton(_ sender: UIButton) {
        memoModel.memo = memo!.text
        memoModel.datatime = Date.now
        
        if (self.mode == .add) {
            // 追加モード
            addDelegate?.addCell(memo: memoModel)
            dismiss(animated: true, completion: nil)
            return
        }
        
        // 編集モード
        editDelegate?.editCell(memo: memoModel, cell: targetCell!)
        dismiss(animated: true, completion: nil)
    }

    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func test() {
        print("testメソッド実行されたよ")
    }
    
}
