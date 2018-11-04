//
//  Extensions.swift
//  SiddharthSuneel-Submission
//
//  Created by Siddharth Suneel on 24/08/18.
//  Copyright © 2018 Siddharth Suneel. All rights reserved.
//

import Foundation

//MARK: String
extension String {
    
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    func localizedWithComment(_ comment:String) -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: comment)
    }        
}
