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


class HBDataManager {
    var featureBannerArray:[HBFeatureBanner] = [HBFeatureBanner]()
    
}


struct HBMobileAppConfig {
}

struct HBFeatureBanner {
    var image:String?
    var text:String?
    var href:String?
}

struct Menu {

}



class ViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    var featureBannerArray:[HBFeatureBanner] = [HBFeatureBanner]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.estimatedRowHeight = 100; //self.tableView.rowHeight;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
    
        
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
    
    //mark - UITableViewDataDelegate methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.featureBannerArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell_Info") as! InfoCell
        
        //cell.textLabel?.text = self.featureBannerArray[indexPath.row].text
        //cell.detailTextLabel?.text = self.featureBannerArray[indexPath.row].href
        
        let featureBanner = self.featureBannerArray[indexPath.row]
        cell.setupCell(featureBanner.text, subTitle: featureBanner.href, imageLink: featureBanner.image)
        //cell.setupCell(nil, subTitle: nil, imageLink: featureBanner.image)
        
        return cell
    }
    
    
    //mark - Load Data methods
    
    func hb_getMobileAppConfig()  {
        let urlString = "http://hypebeast.com/api/mobile-app-config"
        let header:Dictionary<String,String> = ["Content-Type":"application/json","Accept":"application/json"]
        let parameter = ["foo":"bar"]
        
        Alamofire.request(.GET, urlString, parameters: parameter, encoding: .URL , headers:header).responseJSON { returnResponse in
            
            /*
            print("-> request: \(response.request)") // original URL request
            print("-> response: \(response.response)") // URL response
            print("-> data: \(response.data)")     // server data
            print("-> result: \(response.result)")   // result of response serialization
            */
            
            switch returnResponse.result {
                case .Failure(let error):
                print("error: \(error)")
            
            case .Success(let returnJson):
                //print("returnJson: \(returnJson)")
                
                let jsonObj = JSON(returnJson)
                
//                let splashLogoUrl = jsonObj["splash_screen"]["sponsor_logo"].stringValue
//                
//                if splashLogoUrl.isEmpty {
//                    print("splashLogoUrl: \(splashLogoUrl)")
//                } else {
//                    print("splashLogoUrl: \(splashLogoUrl)")
//                }
                
                /*
                let logo = jsonObj["splash_screen"]["sponsor_logo"]
                print ("logo = \(logo)")
                */

                /*
                guard let logoString = jsonObj["splash_screen"]["sponsor_logo"].string else {
                    print("sponsor_logo is not exist")
                    return
                }
                print("logoString: \(logoString)")
                */
                
                
                let logoStringValue = jsonObj["splash_screen"]["sponsor_logo"].stringValue
                print("logoStringValue: \(logoStringValue)")
                
//                if let logo  = jsonObj["splash_screen"]["sponsor_logo"].string {
//                    print("sponsor_logo = \(logo)")
//                } else {
//                    print("sponsor_logo is not exist")
//                }

                
                /*
                guard let myBase = jsonObj["cns"]["base"].string else {
                    print("base not exist")
                    return
                }
                */
                
                let languageCode = "en"
                
                let base = jsonObj[languageCode]["base"].stringValue
                let menu = jsonObj[languageCode]["menu"].arrayValue
                let featurebanner = jsonObj[languageCode]["featurebanner"].arrayValue
                

                for eachJSON in featurebanner {
                    let href = eachJSON["href"].stringValue
                    let text = eachJSON["text"].stringValue
                    let image = eachJSON["image"].stringValue
                    let featureBanner:HBFeatureBanner = HBFeatureBanner(image: image, text: text, href: href)
                    self.featureBannerArray.append(featureBanner)
                    
                }
                
                self.tableView.reloadData()
                
                print(self.featureBannerArray)

//                print("base = \(base)")
//                print("menu = \(menu)")
//                print("featurebanner = \(featurebanner)")
                
                
            
            }


        }
    }
    
    func hb_getMobileAppConfig1()  {
        let urlString = "http://hypebeast.com/api/mobile-app-config"
        let header:Dictionary<String,String> = ["Content-Type":"application/json","Accept":"application/json"]
        let parameter = ["foo":"bar"]
        
        Alamofire.request(.GET, urlString, parameters: parameter, encoding: .URL , headers:header).responseJSON { happy in
            
            /*
            print("-> request: \(response.request)") // original URL request
            print("-> response: \(response.response)") // URL response
            print("-> data: \(response.data)")     // server data
            print("-> result: \(response.result)")   // result of response serialization
            */
            
            let a = happy.result.value?["cns"]??["base"]!
            let b = happy.result.value?["cns"]??["menu"]!
            let c = happy.result.value?["cns"]??["menu"]!
            
            let menuAarray = c!
            
            
            print("begin")
            print("a = \(a!)")
            print("b = \(b!)")
            print("c = \(c!)")
            print("menuAarray = \(menuAarray)")
            print("end")
//            if let jsonObj = happy.result.value {
//                //print("JSON: \(JSON)")
//                let mobileConfigJson = JSON(jsonObj)
//                print("jsonObj: \(mobileConfigJson)")
//                let b = mobileConfigJson.dictionaryObject
//                print("b = \(b!["ja"]!)")
//                let c = b!["ja"]!
//                print("cool")
//                //
//            }
            
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

