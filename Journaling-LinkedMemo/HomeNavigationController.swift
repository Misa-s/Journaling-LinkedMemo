//
//  HomeNavigationController.swift
//  Journaling-LinkedMemo
//
//  Created by Misaki Shimazaki on 2022/02/02.
//

import UIKit

class HomeNavigationController: UINavigationController {

    @IBOutlet weak var navBar: UINavigationBar!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // ナビゲージョンアイテムの文字色
        UINavigationBar.appearance().tintColor = UIColor.white
        
        // ナビゲーションバーのタイトルの文字色
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        
        // ナビゲーションバーの背景色
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemTeal  // eg .black or .white
        
        self.navigationBar.standardAppearance = appearance;
        self.navigationBar.scrollEdgeAppearance = self.navigationBar.standardAppearance
        // Do any additional setup after loading the view.
    }
    

   

}
