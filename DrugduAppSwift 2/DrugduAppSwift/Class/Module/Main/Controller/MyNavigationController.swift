//
//  MyNavigationController.swift
//  DrugduAppSwift
//
//  Created by 沈士新 on 2018/6/21.
//  Copyright © 2018年 danny. All rights reserved.
//

import UIKit
import SwiftTheme
extension  MyNavigationController : SelfAware{
    static func awake() {
        MyNavigationController.classInit()
    }
    
    static func classInit() {
        swizzleMethod
    }
    @objc func swizzled_viewWillAppear(_ animated: Bool) {
        swizzled_viewWillAppear(animated)
        print("swizzled_viewWillAppear")
        //设置属性
        let navBar = UINavigationBar.appearance();
        navBar.barTintColor = UIColor.init(hexString: "#027bd6");
        
        navBar.shadowImage = UIImage();
        navBar.tintColor = UIColor.clear;
        navBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.black,NSAttributedStringKey.font : UIFont.systemFont(ofSize: 18)];
        
    }
    private static let swizzleMethod: Void = {
        let originalSelector = #selector(viewWillAppear(_:))
        let swizzledSelector = #selector(swizzled_viewWillAppear(_:))
        swizzlingForClass(UIViewController.self, originalSelector: originalSelector, swizzledSelector: swizzledSelector)
    }()
    private static func swizzlingForClass(_ forClass: AnyClass, originalSelector: Selector, swizzledSelector: Selector) {
        let originalMethod = class_getInstanceMethod(forClass, originalSelector)
        let swizzledMethod = class_getInstanceMethod(forClass, swizzledSelector)
        guard (originalMethod != nil && swizzledMethod != nil) else {
            return
        }
        if class_addMethod(forClass, originalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!)) {
            class_replaceMethod(forClass, swizzledSelector, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
        } else {
            method_exchangeImplementations(originalMethod!, swizzledMethod!)
        }
    }
    
}

class MyNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let navigationBar = UINavigationBar.appearance();
        navigationBar.theme_tintColor = "colors.black";
        
        let bgImage = UIImage.init(color: UIColor.init(hexString: "#027bd6"));
        navigationBar.tintColor = UIColor.init(hexString: "#ffffff")
        navigationBar.setBackgroundImage(bgImage, for: UIBarMetrics.default);
//        navigationBar.setBackgroundImage(UIImage(named: "navigation_background"), for: UIBarMetrics.default);
        //        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.init(hexString: "#ffffff"),NSAttributedStringKey.font:UIFont.systemFont(ofSize: 18)];
    }
    
    
    // 拦截 push 操作
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "lefterbackicon_titlebar_24x24_"), style: .plain, target: self, action: #selector(navigationBack))
        }
        super.pushViewController(viewController, animated: true)
    }
    
    /// 返回上一控制器
    @objc private func navigationBack() {
        popViewController(animated: true)
    }
    

 

}
