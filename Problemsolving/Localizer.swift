//
//  Localizer.swift
//  Problemsolving
//
//  Created by 重信和宏 on 5/5/17.
//  Copyright © 2017 Hiro. All rights reserved.
//

import Foundation

private class Localizer {
    
//    static let sharedInstance = Localizer()
//    
//    lazy var localizableDictionary: NSDictionary! = {
//        if let path = Bundle.main.path(forResource: "Localizable", ofType: "plist") {
//            return NSDictionary(contentsOfFile: path)
//        }
//        fatalError("Localizable file NOT found")
//    }()
//    
//    func localize(string: String) -> String {
//        guard let localizedString = (localizableDictionary.valueForKey(string) as AnyObject).value("value") as? String else {
//            assertionFailure("Missing translation for: \(string)")
//            return ""
//        }
//        return localizedString
//    }
  }

extension String {
    func localized(lang:String) ->String {
        
        let path = Bundle.main.path(forResource: lang, ofType: "strings")
        let bundle = Bundle(path: path!)
        
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }}



//extension String {
//    var localized: String {
//        return Localizer.sharedInstance.localize(string: self)
//    }
//}

