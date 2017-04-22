//
//  TFHomeViewController.swift
//  TrueFace
//
//  Created by zhouen on 2017/4/6.
//  Copyright © 2017年 zhouen. All rights reserved.
//

import UIKit

class TFHomeViewController: UIViewController {

    let url = "http://192.168.1.11:8080/test/user/uploadAvatar"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NIRequest.getRequest("https://oxyxx.com:8443/mrenApp/category/getCategory_1.do", success: { (dictResponse) in
            print(dictResponse)
        }) { (error) in
            print(error)
        }
        
        NIRequest.postRequest("https://xxx.com", params: ["title":"xxx"], success: { (dictResponse) in
            print(dictResponse)
        }) { (error) in
            print(error)
        }
        
        
        
        
        let button = UIButton(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        view.addSubview(button)
        button.backgroundColor = UIColor.red
        button.addTarget(self, action: #selector(TFHomeViewController.request), for: .touchUpInside)
        
        


        // Do any additional setup after loading the view.
    }
    
    func  request()  {
        let image = UIImage(named: "mbase.jpg")
        let data = UIImagePNGRepresentation(image!);
        
        NIRequest.upLoadImage(url, data: data!, success: { (dict) in
            
        }) { (error) in
            
        }
        
        NIRequest.upLoadFiles(url, data: [data!,data!], success: { dictResponse in
            
        }) { error in
            
        }
        
        NIRequest.upLoadFiles(url, data: [data!,data!],names: ["image1","image0"],fileNames: ["image1.png","imge.png"], params: ["fileNmae":"meinv"], success: { (dict) in
            
        }) { (error) in
            
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
