//
//  ViewController.swift
//  SwiftWorkOut
//
//  Created by Eric Ho on 18/11/2015.
//  Copyright © 2015 Eric Ho. All rights reserved.
//

import UIKit
import Alamofire


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //good stuff
        testNetwork()
        testStringFunc()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func testStringFunc(_: Void)-> Void {
        let inputStr = "long src=test& with hello"
        let outputStr = inputStr.stringBetween("src=", and: "& ")
        print("input: \(inputStr)")
        print("output: \(outputStr)")
    }
    
    func testNetwork() -> Void {
        let request = Alamofire.request(.GET, "https://httpbin.org/get")
        
        Alamofire.request(.GET, "https://httpbin.org/get", parameters: ["foo": "bar"])
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
        }

        print("request: \(request)")
    }


}

