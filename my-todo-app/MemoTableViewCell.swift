//
//  MemoTableViewCell.swift
//  my-todo-app
//
//  Created by Misaki Shimazaki on 2022/01/19.
//

import UIKit

class MemoTableViewCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView?
    @IBOutlet weak var memo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        img?.image = UIImage(systemName: "swift")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
