//
//  FontAwesomeUtil.swift
//  Journaling-LinkedMemo
//
//  Created by Misaki Shimazaki on 2022/02/05.
//

import Foundation
import FontAwesome_swift

/// FontAwesome Image/Textの生成用クラス
class FontAwesomeImageUtil {
    
    enum Mode {
        case nomal
        case selected
    }
    
    /// 色ここにいったんまとめてる
    static var primary: UIColor = .systemTeal;
    static var secondary: UIColor = .gray;
    static var white: UIColor = .white;
    
    
    
    /// Memo追加用ボタン
    static func addButton() -> UIImage {
        return UIImage.fontAwesomeIcon(name: .plus, style: .solid, textColor: white, size: CGSize(width: 40, height: 40))
    }
    
    /// Memoリストのセル用 編集ボタンImage(nomal)
    static func editButtonForCell() -> UIImage {
        return UIImage.fontAwesomeIcon(name: .penAlt, style: .solid, textColor: primary, size: CGSize(width: 20, height: 20))
    }
    
    /// キャンセルボタン（モーダル）
    static func canselButtonForModal() -> UIImage {
        return UIImage.fontAwesomeIcon(name: .windowClose, style: .solid, textColor: primary, size: CGSize(width: 40, height: 40))
    }
    
    /// キーボードツールバー用：画像アイコン
    static func selectPhotoForKeyboardToolBar() -> UIImage {
        return UIImage.fontAwesomeIcon(name: .images, style: .solid, textColor: primary, size: CGSize(width: 30, height: 30))
    }
    
    /// 写真選択用のチェックマーク
    static func checkForImagePicker() -> UIImage {
        return UIImage.fontAwesomeIcon(name: .check, style: .solid, textColor: primary, size: CGSize(width: 30, height: 30))
    }
    
    /// メインタブ用＜Home＞
    static func homeForTabItem(mode:Mode) -> UIImage {
        switch mode {
            case .nomal:
                return UIImage.fontAwesomeIcon(name: .home, style: .solid, textColor: secondary, size: CGSize(width: 40, height: 40))
            case .selected:
                return UIImage.fontAwesomeIcon(name: .home, style: .solid, textColor: primary, size: CGSize(width: 40, height: 40))
        }
    }
    /// メインタブ用＜検索＞
    static func searchForTabItem(mode:Mode) -> UIImage {
        switch mode {
            case .nomal:
                return UIImage.fontAwesomeIcon(name: .search, style: .solid, textColor: secondary, size: CGSize(width: 40, height: 40))
            case .selected:
                return UIImage.fontAwesomeIcon(name: .search, style: .solid, textColor: primary, size: CGSize(width: 40, height: 40))
        }
    }
    
}
