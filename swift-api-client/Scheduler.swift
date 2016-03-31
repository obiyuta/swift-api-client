//
//  Scheduler.swift
//  swift-api-client
//
//  Created by obiyuta on 2016/03/20.
//  Copyright © 2016 obiyuta. All rights reserved.
//

import Foundation
import RxSwift

class Scheduler {

    static let sharedInstance = Scheduler()

    let backgroundWorkScheduler: ImmediateSchedulerType
    let mainScheduler: SerialDispatchQueueScheduler

    private init() {
        let operationQueue = NSOperationQueue()
        operationQueue.maxConcurrentOperationCount = 2
        operationQueue.qualityOfService = NSQualityOfService.UserInitiated
        backgroundWorkScheduler = OperationQueueScheduler(operationQueue: operationQueue)
        mainScheduler = MainScheduler.instance
    }

}