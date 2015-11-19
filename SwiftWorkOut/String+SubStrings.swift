//
//  String+SubStrings.swift
//  hypebeast
//
//  Created by Felix Li on 14/8/15.
//  Copyright (c) 2015 42Labs. All rights reserved.
//

import Foundation

extension String{
    
    func stringBetween(beforeString: String, and afterString: String) -> String{
        
        let scanner = NSScanner(string:self)
        var scanned: NSString?
        
        if scanner.scanUpToString(beforeString, intoString:nil) {
            scanner.scanString(beforeString, intoString:nil)
            if scanner.scanUpToString(afterString, intoString:&scanned) {
                let result: String = scanned as String!
                
                return result
            }
        }
        
        return self
    }
}