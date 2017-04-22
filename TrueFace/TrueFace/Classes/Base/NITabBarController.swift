//
//  NITabBarController.swift
//  TrueFace
//
//  Created by zhouen on 2017/4/6.
//  Copyright © 2017年 zhouen. All rights reserved.
//

import UIKit

class NITabBarController: UITabBarController {
    
    fileprivate let classKey = "class"
    fileprivate let titleKey = "title"
    fileprivate let imgKey = "img"
    fileprivate let selImgkey = "selectImg"
    fileprivate var childItems:[[String:String]]
    

    init() {
        self.childItems = [
            [classKey:"TFHomeViewController",
             titleKey:"首页",
             imgKey:"",
             selImgkey:"" ],
            
            [classKey:"TFHomeViewController",
             titleKey:"首页",
             imgKey:"",
             selImgkey:"" ],
            
        ]
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChildItems()

        
        
        // Do any additional setup after loading the view.
    }


}

extension NITabBarController {
    
    func setupChildItems() {
     
        self.childItems = [
            [classKey:"TFHomeViewController",
             titleKey:"首页",
             imgKey:"",
             selImgkey:"" ],
            
            [classKey:"TFHomeViewController",
             titleKey:"首页",
             imgKey:"",
             selImgkey:"" ],
            
        ]

        
        for dict in childItems {
            
            guard let className = dict[classKey],
                let title = dict[titleKey],
                let imgStr = dict[imgKey],
                let selImgStr = dict[selImgkey],
                let cls = NSClassFromString(Bundle.main.namespace + "." + className) as? UIViewController.Type
            else {
                continue
            }
            
            let vc = cls.init()
            let nav = NIBaseNavigationController(rootViewController:vc)
            let item = nav.tabBarItem
            item?.title = title;
            item?.image=UIImage(named:imgStr)
            item?.selectedImage=UIImage(named:selImgStr)?.withRenderingMode(.alwaysOriginal)
            
            item?.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.red], for: .selected)
            item?.setTitleTextAttributes(
                [NSFontAttributeName: UIFont.systemFont(ofSize: 12)],
                for: .normal)
            
            addChildViewController(nav)
            
        }

        
    }
    
    

}
