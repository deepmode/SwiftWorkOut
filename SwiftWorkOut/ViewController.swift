//
//  ViewController.swift
//  SwiftWorkOut
//
//  Created by Eric Ho on 18/11/2015.
//  Copyright © 2015 Eric Ho. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //good stuff
        
        //testNetwork()
        //testStringFunc()
        //testHeaderAuthentication()
        
        self.hb_getMobileAppConfig()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //var jsonObj:JSON?
    
    func hb_getMobileAppConfig()  {
        let urlString = "http://hypebeast.com/api/mobile-app-config"
        let header:Dictionary<String,String> = ["Content-Type":"application/json","Accept":"application/json"]
        let parameter = ["foo":"bar"]
        
        Alamofire.request(.GET, urlString, parameters: parameter, encoding: .URL , headers:header).responseJSON { response in
            
            /*
            print("-> request: \(response.request)") // original URL request
            print("-> response: \(response.response)") // URL response
            print("-> data: \(response.data)")     // server data
            print("-> result: \(response.result)")   // result of response serialization
            */
            
            if let jsonObj = response.result.value {
                //print("JSON: \(JSON)")
                let mobileConfigJson = JSON(jsonObj)
                print("jsonObj: \(mobileConfigJson)")
                let b = mobileConfigJson.dictionaryObject
                print("b = \(b!["ja"]!)")
                let c = b!["ja"]!
                print("cool")
                //
            }
            
        }
    }
    
    func testHeaderAuthentication() {
        let user = "user"
        let password = "password"
        
        let credentialData = "\(user):\(password)".dataUsingEncoding(NSUTF8StringEncoding)!
        let base64Credentials = credentialData.base64EncodedStringWithOptions([])
        
        let headers = ["Authorization": "Basic \(base64Credentials)"]
        
        Alamofire.request(.GET, "https://httpbin.org/basic-auth/user/password", headers: headers)
            .responseJSON { response in
                debugPrint(response)
        }
    }
    
    func testStringFunc(_: Void)-> Void {
        let inputStr = "long src=test& with hello"
        let outputStr = inputStr.stringBetween("src=", and: "& ")
        print("input: \(inputStr)")
        print("output: \(outputStr)")
    }
    
    func testNetwork() -> Void {
        //let urlString = "http://hypebeast.com/api/mobile-app-config"
        //let header:Dictionary<String,String> = ["Content-Type":"application/json","Accept":"application/json"]
        
        let urlString = "http://hypebeast.com/search?s=good"
        let header:Dictionary<String,String> = ["Content-Type":"application/json","Accept":"application/json"]
        
        //let request = Alamofire.request(.GET, "https://httpbin.org/get")
        //let request = Alamofire.request(.GET, urlString)
        
        
        
        //  Alamofire.request(.GET, urlString, parameters: ["foo": "bar"])
        //Alamofire.request(.GET, urlString, parameters: ["foo": "bar"]).responseJSON {response in
        
        Alamofire.request(.GET, urlString).responseString { (response) -> Void in
            
            
            print("Success: \(response.result.isSuccess)")
            print("Response String: \(response.result.value)")
        }
        
        
        Alamofire.request(.GET, urlString, parameters: ["foo": "bar"], encoding: .URL , headers:header).responseJSON { response in
            print(response.request)  // original URL request
            print(response.response) // URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
    }
    
    
}

