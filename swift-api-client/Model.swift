//
//  Item.swift
//  swift-api-client
//
//  Created by obiyuta on 2016/03/20.
//  Copyright © 2016 obiyuta. All rights reserved.
//

import Foundation
import ObjectMapper


// MARK: - Payload

class Payload: Mappable {
    
    var items: [Item]?
    var hasMore: Bool = false
    var quotaMax: Int?
    var quotaRemaining: Int?
    
    required init?(_ map: Map) {}
    func mapping(map: Map) {
        items <- map["items"]
        hasMore <- map["has_more"]
        quotaMax <- map["quota_max"]
        quotaRemaining <- map["quota_remaining"]
    }
}


// MARK: - Item

class Item: Mappable {
    
    var answerCount: Int?
    var creationDate: Int?
    var isAnswered: Bool?
    var lastActivityDate: Int?
    var lastEditDate: Int?
    var link: NSURL?
    var owner: User?
    var questionId: Int?
    var score: Int?
    var tags: [String]?
    var title: String?
    var viewCount: Int?
    
    required init?(_ map: Map) {}
    
    func mapping(map: Map) {
        answerCount <- map["answer_count"]
        creationDate <- map["creation_date"]
        isAnswered <- map["is_answered"]
        lastActivityDate <- map["last_activity_date"]
        lastEditDate <- map["last_edit_date"]
        link <- (map["link"], URLTransform())
        owner <- map["owner"]
        questionId <- map["question_id"]
        score <- map["score"]
        tags <- map["tags"]
        title <- map["title"]
        viewCount <- map["view_count"]
    }
    
}


// MARK: - User

class User: Mappable {
    
    var acceptRate: Int?
    var displayName: String?
    var link: NSURL?
    var profileImage: NSURL?
    var reputation: Int?
    var userId: Int?
    var userType: String?
    
    required init?(_ map: Map) {}
    
    func mapping(map: Map) {
        acceptRate <- map["accept_rate"]
        displayName <- map["display_name"]
        link <- (map["link"], URLTransform())
        profileImage <- map["profile_image"]
        reputation <- map["reputation"]
        userId <- map["user_id"]
        userType <- map["user_type"]
    }
    
}
