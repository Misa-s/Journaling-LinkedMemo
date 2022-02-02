//
//  TabBarController.swift
//  Journaling-LinkedMemo
//
//  Created by Misaki Shimazaki on 2022/02/02.
//

import UIKit
import FontAwesome_swift

class TabBarController: UITabBarController {

    @IBOutlet weak var mainTabbar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setTabBarItem(index: 0, titile: "Home", image: UIImage.fontAwesomeIcon(name: .home, style: .solid, textColor: .gray, size: CGSize(width: 40, height: 40)), selectedImage: UIImage.fontAwesomeIcon(name: .home, style: .solid, textColor: .systemTeal, size: CGSize(width: 40, height: 40)), offColor: UIColor.gray, onColor: UIColor.systemTeal)
        
        self.setTabBarItem(index: 1, titile: "Search", image: UIImage.fontAwesomeIcon(name: .search, style: .solid, textColor: .gray, size: CGSize(width: 40, height: 40)), selectedImage: UIImage.fontAwesomeIcon(name: .search, style: .solid, textColor: .systemTeal, size: CGSize(width: 40, height: 40)), offColor: UIColor.gray, onColor: UIColor.systemTeal)
        
        UITabBarItem.appearance().setTitleTextAttributes([.font : UIFont.systemFont(ofSize: 11)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([.font : UIFont.systemFont(ofSize: 11)], for: .selected)
        
    }
    
    func setTabBarItem(index: Int, titile: String, image: UIImage, selectedImage: UIImage,  offColor: UIColor, onColor: UIColor) -> Void {
        let tabBarItem = self.mainTabbar.items![index]
        tabBarItem.title = titile
        tabBarItem.image = image.withRenderingMode(.alwaysOriginal)
        tabBarItem.selectedImage = selectedImage.withRenderingMode(.alwaysOriginal)
        tabBarItem.setTitleTextAttributes([ .foregroundColor : offColor], for: .normal)
        tabBarItem.setTitleTextAttributes([ .foregroundColor : onColor], for: .selected)
    }

}
