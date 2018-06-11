//
//  NetworkTool.swift
//  News
//
//  Created by zlf on 2018/5/4.
//  Copyright © 2018年 hrscy. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import HandyJSON


protocol NetworkToolProtocol {
    // MARK: - --------------------------------- 首页 home  ---------------------------------
    // MARK: 首页顶部新闻标题的数据
    
//    static func loadHomeNewsTitleData(completionHandler: @escaping (_ newsTitles: [String]) -> ())
    static func loadHomeNewsTitleData(completionHandler: @escaping (_ newsTitles: [HomeNewsTitle]) -> ())
    
    // MARK: 我的界面 cell 的数据
    static func loadMyCellData(completionHandler: @escaping (_ sections: [[MyCellModel]]) -> ())
    //我的关注数据
    static func loadMyConcern(completionHandler: @escaping (_ concerns: [MyConcern]) -> ())
//    static func loadMyConcern()
}
extension NetworkToolProtocol{

    static func loadHomeNewsTitleData(completionHandler: @escaping (_ newsTitles: [HomeNewsTitle]) -> ()){
        let url = Base_URL + "/article/category/get_subscribed/v1/?"
        let params = ["device_id": device_id,
                      "iid": iid]
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else {
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else {return}
                if let dataDict = json["data"].dictionary {
                    if let datas = dataDict["data"]?.arrayObject {
                        var titles = [HomeNewsTitle]()
                        titles.append(HomeNewsTitle.deserialize(from: "{\"category\": \"\", \"name\": \"推荐\"}")!)
                        let bbcded = datas.flatMap{(HomeNewsTitle.deserialize(from: $0 as? NSDictionary))}
                        
                        titles += bbcded
                        completionHandler(titles)
                    }
                }
            }
            
        }
      
        
    }
    
    static func loadMyCellData(completionHandler: @escaping (_ sections: [[MyCellModel]]) -> ()){
        let url = Base_URL + "/user/tab/tabs/?"
        let params = ["device_id": device_id]
        
        
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else {
                //
                return
            }
            if let value = response.result.value {
                var json = JSON(value)
                guard json["message"] == "success" else {
                    return
                }
                if let data = json["data"].dictionary {
                    print(data)
                    if let sections = data["sections"]?.array{
                        var sectionArray = [[MyCellModel]]()
//                        type(of: sectionArray)
                        
                        for item in sections {
                            var rows = [MyCellModel]()
                            for row in item.arrayObject!{
                                let myCellModel = MyCellModel.deserialize(from: row as? NSDictionary)
                                rows.append(myCellModel!)
                            }
                            sectionArray.append(rows)
                        }
                        completionHandler(sectionArray)
                    }
                }
                
            }
        }
        
    }
    
    static func loadMyConcern(completionHandler: @escaping (_ concerns: [MyConcern]) -> ()) {
        
        let url = Base_URL + "/concern/v2/follow/my_follow/?"
        let params = ["device_id": device_id]
        
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            // 网络错误的提示信息
       
            guard response.result.isSuccess else { return }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else { return }
                if let datas = json["data"].arrayObject {
//                var titles = [MyConcern]()
//                   for datae in datas
//                   {
//                   let bbv = MyConcern.deserialize(from: datae as? Dictionary)
//                    titles.append(bbv!)
//                    }
//                    completionHandler(titles)
              //同上
            completionHandler(datas.flatMap{ MyConcern.deserialize(from: $0 as? Dictionary) })
                }
            }
        }
    }
    //我的关注数据
//    static func loadMyConcern(){
//
//    }
}
struct NetworkTool: NetworkToolProtocol {

    
    
}
/////主题类注释，终于可以用了
