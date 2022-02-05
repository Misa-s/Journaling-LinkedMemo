//
//  ImagePickerDelegate.swift
//  Journaling-LinkedMemo
//
//  Created by Misaki Shimazaki on 2022/02/05.
//

import Foundation
import DKImagePickerController

class ImagePickerViewController: DKImagePickerController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 写真の選択
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemTeal
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemTeal]
        self.navigationBar.standardAppearance = appearance;
        self.navigationBar.scrollEdgeAppearance = self.navigationBar.standardAppearance
    
    }
}
