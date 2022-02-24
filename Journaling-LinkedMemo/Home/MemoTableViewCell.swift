//
//  MemoTableViewCell.swift
//  Journaling-LinkedMemo
//
//  Created by Misaki Shimazaki on 2022/01/28.
//

import UIKit

protocol EditButtonDelegate {
    func openEditModal(memo: Memo, cell: MemoTableViewCell)
}

class MemoTableViewCell: UITableViewCell, UICollectionViewDelegate {
    let minimumLineSpacing:CGFloat = 3.0
    
    @IBOutlet weak var editButton: UIButton!
    
    var delegate: EditButtonDelegate?
    var memo: Memo?
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    var images: [UIImage] = []
    
    @IBOutlet weak var memoLabel: UILabel!
    @IBOutlet weak var datetimeLabel: UILabel!
    
    func setFields(for memo: Memo) {
        //　編集ボタン
        self.editButton.setImage(FontAwesomeImageUtil.editButtonForCell(), for: .normal)
        self.memo = memo
        // Cellのメモ
        self.memoLabel.text = memo.memo
        // Cellの投稿時間
        self.datetimeLabel.text = memo.getStrDate()
        //　画像の描画
        if let imgs = memo.images {
            setImages(orderSet: imgs)
        }
        resizeCollectionViewHeight(imageCount: self.images.count)
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
    /// 編集モーダルの表示
    @IBAction func openEditModal(_ sender: UIButton) {
        delegate?.openEditModal(memo: self.memo!, cell: self)
    }
    
    func setImages(orderSet: NSSet){
        let itemSize  = getImageSize()
        // CollectionViewのレイアウト
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(
            width: itemSize,
            height: itemSize
        )
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = minimumLineSpacing
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.collectionView.collectionViewLayout = flowLayout
        
        // 画像を読み込む
        self.images = []
        for imageEntity in orderSet  {
            if let uiimage = UIImage(data: (imageEntity as! Image).data!) {
                self.images.append(uiimage)
            }
        }
        self.collectionView.reloadData()
    }
    
    func resizeCollectionViewHeight(imageCount :Int){
        let rowCount = imageCount / 3 + (imageCount % 3 == 2 ? 1 : imageCount % 3)
        self.collectionViewHeightConstraint.constant = CGFloat(getImageSize()) * CGFloat(rowCount) + minimumLineSpacing
    }
    
    func getImageSize() -> CGFloat {
        return self.collectionView.frame.width / 3 - 3.0
    }
    
}

extension MemoTableViewCell :UICollectionViewDataSource {
    /// CollectionViewのCell追加
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->
    UICollectionViewCell {
        let imageSize  = getImageSize()
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "memoListCollectionCell", for: indexPath)
        let image = self.images[indexPath.row]
        let imageView = UIImageView(image: image.resized(size: CGSize(width: imageSize, height: imageSize)))
        cell.sizeToFit()
        cell.addSubview(imageView)
        cell.layer.cornerRadius = 10
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
}

