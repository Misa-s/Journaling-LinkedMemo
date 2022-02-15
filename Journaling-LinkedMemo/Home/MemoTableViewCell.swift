//
//  MemoTableViewCell.swift
//  Journaling-LinkedMemo
//
//  Created by Misaki Shimazaki on 2022/01/28.
//

import UIKit

protocol EditButtonDelegate {
    func openEditModal(cell: MemoTableViewCell, memo: Memo)
}

class MemoTableViewCell: UITableViewCell, UICollectionViewDelegate {
    private var imageSize: CGFloat = 200.0
    
    @IBOutlet weak var editButton: UIButton!
    var delegate: EditButtonDelegate?
    var memo: Memo?
//    var collectionView: UICollectionView!
    @IBOutlet weak var collectionView: UICollectionView!
    
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
        } else {
            // 画像がなければ小さくしちゃう
            self.collectionView.frame = CGRect(x: 0,y: 0,width: 0,height: 0)
        }
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
    /// 編集モーダルの表示
    @IBAction func openEditModal(_ sender: UIButton) {
        delegate?.openEditModal(cell: self, memo: self.memo!)
    }
    
    func setImages(orderSet: NSOrderedSet){
        // CollectionViewのレイアウト
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(
            width: self.collectionView.frame.width / 2,
            height: self.collectionView.frame.width / 2
        )
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.collectionView.collectionViewLayout = flowLayout
        
        // 画像を読み込む
        for imageEntity in orderSet  {
            if let uiimage = UIImage(data: (imageEntity as! Image).data!) {
                self.images.append(uiimage)
            }
        }
        self.collectionView.reloadData()
    }
    
//    func createCollectionView(size: CGSize){
//
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
//        self.collectionView.dataSource = self
//
//        let memoRect: CGRect = self.memoLabel.frame
//        collectionView.frame = CGRect(x: memoRect.minX,
//                                      y:memoRect.maxY + 15, // memoエリアとの隙間
//                                      width: memoRect.maxX - memoRect.minX,
//                                      height: imageSize
//        )
//
//        self.addSubview(collectionView)
//    }
}

extension MemoTableViewCell :UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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

