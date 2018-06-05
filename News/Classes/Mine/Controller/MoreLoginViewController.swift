//
//  MoreLoginViewController.swift
//  News
//
//  Created by zlf on 2018/5/31.
//  Copyright © 2018年 hrscy. All rights reserved.
//

import UIKit

class MoreLoginViewController: UIViewController {

    @IBOutlet weak var iphoneView: UIView!
    
    @IBOutlet weak var vertyView: UIView!
    @IBAction func backBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.iphoneView.layer.borderWidth = 1
        self.iphoneView.layer.borderColor = UIColor(r: 138, g: 138, b: 138).cgColor
        self.vertyView.layer.borderWidth = 1
        self.vertyView.layer.borderColor = UIColor(r: 138, g: 138, b: 138).cgColor
        
        
        // Do any additional setup after loading the view.
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
