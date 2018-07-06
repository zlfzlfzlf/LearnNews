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
import SVProgressHUD


protocol NetworkToolProtocol {
    // MARK: - --------------------------------- 首页 home  ---------------------------------
    // MARK: 首页顶部新闻标题的数据
    
//    static func loadHomeNewsTitleData(completionHandler: @escaping (_ newsTitles: [String]) -> ())
    static func loadHomeNewsTitleData(completionHandler: @escaping (_ newsTitles: [HomeNewsTitle]) -> ())
    
    // MARK: 我的界面 cell 的数据
    static func loadMyCellData(completionHandler: @escaping (_ sections: [[MyCellModel]]) -> ())
    //我的关注数据
    static func loadMyConcern(completionHandler: @escaping (_ concerns: [MyConcern]) -> ())
    ///用户详情
    static func loadUserDetail(userId: Int, completionHandler: @escaping (_ concerns: UserDetail) -> ())
    
    // MARK: 已关注用户，取消关注
    static func loadRelationUnfollow(userId: Int, completionHandler: @escaping (_ user: ConcernUser) -> ())
    // MARK: 点击关注按钮，关注用户
    static func loadRelationFollow(userId: Int, completionHandler: @escaping (_ user: ConcernUser) -> ())
    // MARK: 点击了关注按钮，就会出现相关推荐数据
    static func loadRelationUserRecommend(userId: Int, completionHandler: @escaping (_ concerns: [UserCard]) -> ())
//    // MARK: 获取用户详情的动态列表数据
//    static func loadUserDetailDongtaiList(userId: Int, maxCursor: Int, completionHandler: @escaping (_ cursor: Int,_ dongtais: [UserDetailDongtai]) -> ())
//    // MARK: 获取用户详情的文章列表数据
//    static func loadUserDetailArticleList(userId: Int, completionHandler: @escaping (_ dongtais: [UserDetailDongtai]) -> ())
//    // MARK: 获取用户详情的问答列表数据
//    static func loadUserDetailWendaList(userId: Int, cursor: String, completionHandler: @escaping (_ cursor: String,_ wendas: [UserDetailWenda]) -> ())
//    // MARK: 获取用户详情的动态详细内容 **暂未使用本方法**
//    static func loadUserDetailDongTaiDetailContent(threadId: String, completionHandler: @escaping (_ detailContent: UserDetailDongtai) -> ())
//    // MARK: 获取用户详情的动态转发或引用内容 **暂未使用本方法**
//    static func loadUserDetailDongTaiDetailCommentOrQuote(commentId: Int, completionHandler: @escaping (_ detailComment: UserDetailDongtai) -> ())
//    // MARK: 获取用户详情一般的详情的评论数据
//    static func loadUserDetailNormalDongtaiComents(groupId: Int, offset: Int, count: Int, completionHandler: @escaping (_ comments: [DongtaiComment]) -> ())
//    // MARK: 获取用户详情其他类型的详情的评论数据
//    static func loadUserDetailQuoteDongtaiComents(id: Int, offset: Int, completionHandler: @escaping (_ comments: [DongtaiComment]) -> ())
//    // MARK: 获取动态详情的用户点赞列表数据
//    static func loadDongtaiDetailUserDiggList(id: Int, offset: Int, completionHandler: @escaping (_ comments: [DongtaiUserDigg]) -> ())
//    // MARK: 获取问答的列表数据（提出了问题）
//    static func loadProposeQuestionBrow(qid: Int, enterForm: WendaEnterFrom, completionHandler: @escaping (_ wenda: Wenda) -> ())
//    // MARK: 获取问答的列表数据（提出了问题），加载更多
//    static func loadMoreProposeQuestionBrow(qid: Int, offset: Int, enterForm: WendaEnterFrom, completionHandler: @escaping (_ wenda: Wenda) -> ()
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
    ///我的关注数据
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
    
     /// 获取用户详情数据
    /// - parameter userId: 用户id
    /// - parameter completionHandler: 返回用户详情数据
    /// - parameter userDetail:  用户详情数据
    static func loadUserDetail(userId: Int, completionHandler: @escaping (_ concerns: UserDetail) -> ()) {
        
        let url = Base_URL + "/user/profile/homepage/v4/?"
        let params = ["user_id": userId,
                      "device_id": device_id,
                      "iid": iid]
        
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            // 网络错误的提示信息
//            print(response.request)
            guard response.result.isSuccess else { return }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else { return }
                if let datas = json["data"].dictionaryObject {
                    //                var titles = [MyConcern]()
                    //                   for datae in datas
                    //                   {
                    //                   let bbv = MyConcern.deserialize(from: datae as? Dictionary)
                    //                    titles.append(bbv!)
                    //                    }
                    //                    completionHandler(titles)
                    //同上
                    completionHandler(UserDetail.deserialize(from: datas )!)
                }
            }
        }
    }
    
    static func loadRelationUnfollow(userId: Int, completionHandler: @escaping (_ user: ConcernUser) -> ()) {
        let url = Base_URL + "/2/relation/unfollow/?"
        let params = ["user_id": userId,
                      "device_id": device_id,
                      "iid": iid]
        
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            // 网络错误的提示信息
            
            guard response.result.isSuccess else { return }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else {return }
                    if let data = json["data"].dictionaryObject {
                     completionHandler(ConcernUser.deserialize(from: data["user"] as? Dictionary)!)
                    }
                    
//                print(json["data"]["user"].dictionaryObject)
//                if let user = json["data"]["user"].dictionaryObject {
//                    
//                    completionHandler(ConcernUser.deserialize(from: user)!)
//                }
              
            }
        }
    }
    
    /// 点击关注按钮，关注用户
    /// - parameter userId: 用户id
    /// - parameter completionHandler: 返回用户
    /// - parameter user:  用户信息（暂时不用）
    static func loadRelationFollow(userId: Int, completionHandler: @escaping (_ user: ConcernUser) -> ()) {
        
        let url = Base_URL + "/2/relation/follow/v2/?"
        let params = ["user_id": userId,
                      "device_id": device_id,
                      "iid": iid]
        
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            // 网络错误的提示信息
            guard response.result.isSuccess else { return }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else { return }
                if let data = json["data"].dictionaryObject {
                    completionHandler(ConcernUser.deserialize(from: data["user"] as? Dictionary)!)
                }
            }
        }
    }
    
    static func loadRelationUserRecommend(userId: Int, completionHandler: @escaping (_ concerns: [UserCard]) -> ())
    {
        let url = Base_URL + "/user/relation/user_recommend/v1/supplement_recommends/?"
        let params = ["device_id": device_id,
                      "follow_user_id": userId,
                      "iid": iid,
                      "scene": "follow",
                      "source": "follow"] as [String : Any]
        Alamofire.request(url, parameters:params).responseJSON { response in
            print(response.request)
            guard let value = response.result.value else {
                return
            }
            let json = JSON(value)
            guard json["err_no"] == 0 else {return}
            if let user_cards = json["user_cards"].arrayObject {
                let userArr = user_cards.flatMap({ UserCard.deserialize(from: $0 as? Dictionary)
                    
                })
                
                completionHandler(userArr)
            }
            
        }
        
    }
  

}
struct NetworkTool: NetworkToolProtocol {

    
    
}
/////主题类注释，终于可以用了
