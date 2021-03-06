//
//  AddModalViewController.swift
//  Journaling-LinkedMemo
//
//  Created by Misaki Shimazaki on 2022/01/15.
//

import UIKit
import Photos
import FontAwesome_swift
import DKImagePickerController
import GrowingTextView

protocol AddDelegate: AnyObject {
    func addCell(memo: Memo)
}

protocol EditDelegate: AnyObject {
    func editCell(memo: Memo, indexPath: IndexPath)
}

enum Mode {
    case add
    case edit
}

/// メモの追加・編集用のモーダル
class MemoModalViewController: UIViewController, UINavigationControllerDelegate, UITextViewDelegate {
    
    final var headerHeight: CGFloat = 80.0
    final let toolBarHeight: CGFloat = 50.0
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var memo: GrowingTextView!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    weak var addDelegate: AddDelegate?
    weak var editDelegate: EditDelegate?
    var mode: Mode = .add
    var memoModel: Memo =  DataManager.newMemo() // TODO: initへ
    var targetCellIndexPath: IndexPath?
    var pickerController = ImagePickerViewController()
    
    var images: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // テキスト入力エリアのサイズと位置・値のバインド
        self.memo.text = memoModel.memo
        self.memo.minHeight = 20.0
        self.memo.placeholder = "write..."
        self.memo.backgroundColor = .white
        self.memo.trimWhiteSpaceWhenEndEditing = false
        self.memo.delegate = self
        resizeMemo()
        
        // 日時をセット
        self.datePicker.locale = Locale(identifier: "ja_JP")
        if let dateTime = memoModel.datatime {
            self.datePicker.date = dateTime
        } else {
            self.datePicker.date = Date.now
        }
        
        // 画像表示エリアのデリゲートに自身をセット
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.reloadData()
        
        // キャンセルボタン
        self.cancelButton.setImage(FontAwesomeImageUtil.canselButtonForModal(), for: .normal)
        
        // 投稿ボタン
        changeEnabledForPostButton(textView: self.memo)
        
        // keyboardToolBar
        let bar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: toolBarHeight))
        let selectPhoto = UIBarButtonItem(image: FontAwesomeImageUtil.selectPhotoForKeyboardToolBar(), style: .plain, target: self, action: #selector(openPhotoLibrary))
        bar.tintColor = .systemTeal
        bar.items = [selectPhoto]
        bar.sizeToFit()
        memo.inputAccessoryView = bar
        memo.keyboardAppearance = .dark; // TODO: 背景モードに依存
    }
    
    @IBAction func postButton(_ sender: UIButton) {
        memoModel.memo = memo!.text
        memoModel.datatime = self.datePicker.date
        
        // 既に登録済みのImagesは削除
        memoModel.images = nil // 乱暴か？
        // 新しくImagesを追加
        for uiImage in self.images {
            let imgEntity = DataManager.newImage()
            imgEntity.data = uiImage.pngData()
            memoModel.addToImages(imgEntity)
        }
        
        if (self.mode == .add) {
            // 追加モード
            DataManager.save()
            addDelegate?.addCell(memo: memoModel)
            dismiss(animated: true, completion: nil)
            return
        }
        // 編集モード
        DataManager.save()
        editDelegate?.editCell(memo: memoModel, indexPath: targetCellIndexPath!)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func openPhotoLibrary() {
        // カメラロール表示
        self.pickerController.maxSelectableCount = 6
        self.pickerController.sourceType = .photo
        self.pickerController.showsCancelButton = true
        
        self.pickerController.didSelectAssets = { [self] (assets: [DKAsset]) in
            self.images.removeAll()
            for asset in assets {
                asset.fetchFullScreenImage(completeBlock: { (image: UIImage?, info) in
                    if let img = image {
                        self.images.append(img)
                        let indexPath = IndexPath(row: self.images.count - 1, section: 0)
                        self.collectionView.insertItems(at: [indexPath])
                        changeEnabledForPostButton(textView: self.memo) // 非同期っぽいのでここでやる
                    }})
            }
            self.collectionView.reloadData()
        }
        
        self.present(self.pickerController, animated: true) {}
    }
    
    func setUIImages(memo: Memo){
        self.images = { () -> [UIImage] in
            var images: [UIImage] = []
            if let orderedSet = memo.images {
                for imageEntity in orderedSet  {
                    if let uiimage = UIImage(data: (imageEntity as! Image).data!) {
                        images.append(uiimage)
                    }
                }
                return images
            }
            return []
        }()
        
    }
    
    /// メモ(UITextView)の高さを再調整する
    func resizeMemo() {
        let viewHeight = self.view.bounds.size.height
        let memoY = 115.0 // self.memo.bounds.origin.y
        let collectionViewHeight =  self.images.count > 0 ? imageViewHeigth() : 0.0
        let spaces = 30.0
        let datePickerHeight = 35.0
        self.memo.maxHeight = viewHeight - (memoY + collectionViewHeight + toolBarHeight + spaces + datePickerHeight)
    }
    
    func imageViewHeigth() -> CGFloat {
        return self.collectionView.frame.width / 3
    }
}

extension MemoModalViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, GrowingTextViewDelegate {
    
    func textViewDidChangeHeight(_ textView: GrowingTextView, height: CGFloat) {
        UIView.animate(withDuration: 0.2) {
            self.memo.layoutIfNeeded()
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        changeEnabledForPostButton(textView: textView)
    }
    
    func changeEnabledForPostButton(textView: UITextView) {
        if textView.text.isEmpty && self.images.count < 1 {
            self.postButton.isEnabled = false // 無効
        } else {
            self.postButton.isEnabled = true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        resizeMemo()
        
        let imageViewHeigth = imageViewHeigth()
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath)
        
        let image = self.images[indexPath.row]
        let imageView = UIImageView(image: image.resized(size: CGSize(width: imageViewHeigth, height: imageViewHeigth)))
        
        cell.addSubview(imageView)
        cell.layer.cornerRadius = 10
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let horizontalSpace : CGFloat = 3
        let cellSize : CGFloat = imageViewHeigth() - horizontalSpace
        return CGSize(width: cellSize, height: cellSize)
    }
    
    /// そこら辺をタップするとキーボードを閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
