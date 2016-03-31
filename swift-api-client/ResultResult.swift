
//
//  ResultResult.swift
//  swift-api-client
//
//  Created by obiyuta on 2016/03/20.
//  Copyright © 2016年 obiyuta. All rights reserved.
//

import Foundation
import Result

// TO-DO: As soon as https://github.com/antitypical/Result/issues/77 is resolved, this file should be removed

struct ResultResult<T, Error: ErrorType> {
    typealias t = Result<T, Error>
}
