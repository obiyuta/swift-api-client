//
//  ViewController.swift
//  swift-api-client
//
//  Created by obiyuta on 2016/03/20.
//  Copyright © 2016 obiyuta. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        drawView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension ViewController {

    func drawView() {
        ApiManager.call(Router.Question.Read(id: 24002369))
            .subscribeOn(Scheduler.sharedInstance.backgroundWorkScheduler)
            .observeOn(Scheduler.sharedInstance.mainScheduler)
            .subscribe(
                onNext: { payload in
                    // success

                    // example
                    let screenSize = UIScreen.mainScreen().bounds.size
                    let title = UILabel(frame: CGRect(x: 10, y: 40, width: screenSize.width, height: 40))
                    title.text = payload.items?.first?.title
                    title.numberOfLines = 1

                    self.view.addSubview(title)

                },
                onError: { error in
                    // error
                    debugPrint(error)
                },
                onCompleted: {
                    // completed
                }
            )
            .addDisposableTo(self.bag)
    }

}
