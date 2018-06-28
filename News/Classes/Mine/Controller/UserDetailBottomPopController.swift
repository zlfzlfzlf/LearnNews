//
//  UserDetailBottomPopController.swift
//  News
//
//  Created by zlf on 2018/6/27.
//  Copyright © 2018年 hrscy. All rights reserved.
//

import UIKit

class UserDetailBottomPopController: UIViewController {

    var children = [BottomTabChildren]()
    var didSelectedChild: ((BottomTabChildren) -> ())?
    
    @IBOutlet weak var popTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        popTableView.register(UITableViewCell.self, forCellReuseIdentifier: "\(UITableViewCell.self)")
        popTableView.dataSource = self
        popTableView.delegate = self
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

extension UserDetailBottomPopController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return children.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(UITableViewCell.self)", for: indexPath)
        cell.selectionStyle = .none
        let child = children[indexPath.row]
        cell.textLabel?.text = child.name
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "zlfpop"), object: nil, userInfo: nil)
        didSelectedChild!(children[indexPath.row])
    }
}
