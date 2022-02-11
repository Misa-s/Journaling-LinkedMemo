//
//  UIImageExtension.swift
//  Journaling-LinkedMemo
//
//  Created by Misaki Shimazaki on 2022/02/12.
//

import Foundation

import UIKit

extension UIImage {
    func resized(size: CGSize) -> UIImage {
        // リサイズ後のサイズを指定して`UIGraphicsImageRenderer`を作成する
        let renderer = UIGraphicsImageRenderer(size: size)
        
        return renderer.image { (context) in
            // 描画を行う
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
