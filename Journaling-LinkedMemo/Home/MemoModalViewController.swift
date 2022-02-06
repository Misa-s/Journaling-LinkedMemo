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
class MemoModalViewController: UIViewController, UINavigationControllerDelegate {
    
    final var imageViewHeigth: CGFloat = CGFloat(120)
    final var headerHeight: CGFloat = CGFloat(80)
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var memo: UITextView!
    
    weak var addDelegate: AddDelegate?
    weak var editDelegate: EditDelegate?
    var mode: Mode = .add
    var memoModel: Memo =  DataManager.newMemo() // TODO: initへ
    var targetCell: MemoTableViewCell?
    var images: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // テキスト入力エリアのサイズと位置・値のバインド
        let screenRect = self.view.bounds
        let memoHeight = CGFloat(300) // TODO: screenRect.height - headerHeight - imageViewHeigth
        memo.frame = CGRect(x: 0, y: headerHeight, width: screenRect.width, height: memoHeight)
        memo.text = memoModel.memo
        
        // 画像表示エリアのサイズと位置・値のバインド
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal // 横スクロール
        self.collectionView.collectionViewLayout = layout
        self.collectionView.frame =  CGRect(x:0,y:(headerHeight + memoHeight ),width:screenRect.width,height:imageViewHeigth)
        
        // 画像表示エリアのデリゲートに自身をセット
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        // キャンセルボタン
        self.cancelButton.setImage(FontAwesomeImageUtil.canselButtonForModal(), for: .normal)
        
        // keyboardToolBar
        let bar = UIToolbar()
        let selectPhoto = UIBarButtonItem(image: FontAwesomeImageUtil.selectPhotoForKeyboardToolBar(), style: .plain, target: self, action: #selector(openPhotoLibrary))
        bar.tintColor = .systemTeal
        bar.items = [selectPhoto]
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
        let pickerController = ImagePickerViewController()
        pickerController.maxSelectableCount = 6
        pickerController.sourceType = .photo
        images.removeAll()
        
        pickerController.didSelectAssets = { (assets: [DKAsset]) in
            for asset in assets {
                asset.fetchFullScreenImage(completeBlock: { (image: UIImage?, info) in
                    if let img = image {
                        self.images.append(img)
                        let indexPath = IndexPath(row: self.images.count - 1, section: 0)
                        self.collectionView.insertItems(at: [indexPath])
                    }})
                
            }
            self.collectionView.reloadData()
        }
        
        self.present(pickerController, animated: true) {}
    }
}

extension MemoModalViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //コレクションビューから識別子「TestCell」のセルを取得する。
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath)
        let imageView = UIImageView(image: self.images[indexPath.row])
        cell.addSubview(imageView)
        imageView.sizeToFit()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let horizontalSpace : CGFloat = 10
        let cellSize : CGFloat = imageViewHeigth - horizontalSpace
        return CGSize(width: cellSize, height: cellSize)
    }
}
