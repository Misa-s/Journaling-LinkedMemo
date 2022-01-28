//
//  MemoTableViewCell.swift
//  my-todo-app
//
//  Created by Misaki Shimazaki on 2022/01/28.
//

import UIKit

protocol EditButtonDelegate {
    func openEditModal(cell: MemoTableViewCell, memo: Memo)
}

class MemoTableViewCell: UITableViewCell {
    
    var delegate: EditButtonDelegate?
    var memo: Memo?
    
    @IBOutlet weak var memoLabel: UILabel!
    @IBOutlet weak var datetimeLabel: UILabel!
    
    /// 編集モーダルの表示
    @IBAction func openEditModal(_ sender: UIButton) {
        delegate?.openEditModal(cell: self, memo: self.memo!)
    }
    
}
