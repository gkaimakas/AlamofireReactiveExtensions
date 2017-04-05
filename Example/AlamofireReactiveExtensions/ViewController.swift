//
//  ViewController.swift
//  AlamofireReactiveExtensions
//
//  Created by gkaimakas on 03/29/2017.
//  Copyright (c) 2017 gkaimakas. All rights reserved.
//

import Alamofire
import AlamofireReactiveExtensions
import ReactiveSwift
import Result
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let disposable = Alamofire.request("http://jsonplaceholder.typicode.com/posts/1")
            .reactive
            .responseString()
            .map { (response: DataResponse<String>) -> String? in
                return response.value
            }
            .startWithValues { (result: String?) in
                self.navigationItem.title = result
                print(result ?? "")
            }
        
        if disposable.isDisposed == false {
            disposable.dispose()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

