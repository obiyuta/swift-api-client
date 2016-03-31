//
//  ApiRouter.swift
//  swift-api-client
//
//  Created by obiyuta on 2016/03/20.
//  Copyright © 2016 obiyuta. All rights reserved.
//

import Foundation
import Alamofire

class Router {

    class Question {
        class Read: Requestable {
            typealias ResponseType = Payload
            var path = "questions"
            var method: Alamofire.Method = .GET
            var parameters: [String: AnyObject] = ["":""]
            init(id: Int) {
                path = NSURL(fileURLWithPath: path).URLByAppendingPathComponent(String(id)).path!
            }
        }
    }
    
}
