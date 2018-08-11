//
//  GSTabBarViewController.swift
//  DrugduAppSwift
//
//  Created by 沈士新 on 2018/6/21.
//  Copyright © 2018年 danny. All rights reserved.
//

import UIKit

//MyDduVC
class GSTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabBar = UITabBar.appearance();
        tabBar.backgroundImage = UIImage.init(color: UIColor(hexString: "#f5f8fa"));
        tabBar.shadowImage = UIImage.init(color: UIColor(hexString: "#d9e3ed"));
        
        let home = DDUHomeVC();
        let nav0  = addChildVC(viewController: home, title: "Home", image: "home", selectedImage: "home_c");
        addChildViewController(nav0);
        
        let inquirycart = DDUInquiryCartVC();
        let nav1  = addChildVC(viewController: inquirycart, title: "Inquiry Cart", image: "Inquirycart", selectedImage: "Inquirycart_c");
        addChildViewController(nav1);
        
        let nav2 = addChildVC(viewController: GSViewController(), title: "Post", image: "plus", selectedImage: "plus");
        addChildViewController(nav2);
        nav2.tabBarItem.imageInsets = UIEdgeInsetsMake(-8, 0, 8, 0);
        
    
        let message = DDURecentMessageVC();
        let nav3  = addChildVC(viewController: message, title: "Message", image: "message", selectedImage: "message_c");
        addChildViewController(nav3);
        
        let myDdu = DDURecentMessageVC();
        let nav4  = addChildVC(viewController: myDdu, title: "My Ddu", image: "my", selectedImage: "my_c");
        addChildViewController(nav4);
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        UIApplication.shared.statusBarStyle = .lightContent;
    }
   
    
    private func addChildVC(viewController:UIViewController,title:String,image:String,selectedImage:String) ->UINavigationController{
        viewController.title = title;
        viewController.tabBarItem.image = UIImage(named: image)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal);
        viewController.tabBarItem.selectedImage = UIImage(named: selectedImage)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal);
        let font = UIFont.systemFont(ofSize: 10);
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor.init(hexString: "#027bd6"),NSAttributedStringKey.font:font], for: UIControlState.selected);
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor.init(hexString: "#333333"),NSAttributedStringKey.font:font], for: UIControlState.normal);
        
        let nav = MyNavigationController(rootViewController: viewController);
        

        return nav;
    }
    
    
  
    
    


}
