//
//  AddModalViewController.swift
//  Journaling-LinkedMemo
//
//  Created by Misaki Shimazaki on 2022/01/15.
//

import UIKit
import Photos
import FontAwesome_swift

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
class MemoModalViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var memo: UITextView!
    
    weak var addDelegate: AddDelegate?
    weak var editDelegate: EditDelegate?
    var mode: Mode = .add
    var index: Int = -1
    var memoModel: Memo =  DataManager.newMemo() // TODO: initへ
    var targetCell: MemoTableViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        let screenRect = UIScreen.main.bounds
        memo.frame = CGRect(x: 0, y: 80, width: screenRect.width, height: screenRect.height)
        memo.text = memoModel.memo
        
        // キャンセルボタン
        self.cancelButton.setImage(FontAwesomeImageUtil.canselButtonForModal(), for: .normal)
        
        // keyboardToolBar
        let bar = UIToolbar()
        let img = UIImage.fontAwesomeIcon(name: .images, style: .solid, textColor: .systemTeal, size: CGSize(width: 20, height: 20))
        let reset = UIBarButtonItem(image: img, style: .plain, target: self, action: #selector(openPhotoLibrary))
        bar.items = [reset]
        bar.sizeToFit()
        memo.inputAccessoryView = bar
        
        memo.keyboardAppearance = .dark; // TODO: 背景モードに依存
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
    
    @objc func openPhotoLibrary() {
        // カメラロール表示
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary // 「.camera」にすればカメラを起動できる
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = ["public.image"]
        present(imagePickerController,animated: true,completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 選択した写真を取得する
//                let image = info[.originalImage] as! UIImage
                // ビューに表示する
                //imageView.image = image
        print("カメラロールから写真を選択する")
        picker.dismiss(animated: true)
    }
}
