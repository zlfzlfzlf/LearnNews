//
//  UserDetailBottomPushController.swift
//  News
//
//  Created by zlf on 2018/6/27.
//  Copyright © 2018年 hrscy. All rights reserved.
//

import UIKit
import WebKit

class UserDetailBottomPushController: UIViewController {
    var url: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let webView = WKWebView()
        webView.frame = CGRect(x: 0, y: -44, width: screenWidth, height: screenHeight + 44)
        webView.load(URLRequest(url: URL(string: url)!))
      view.addSubview(webView)
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
