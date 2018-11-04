//
//  Constants.swift
//  SiddharthSuneel-Submission
//
//  Created by Siddharth Suneel on 24/08/18.
//  Copyright © 2018 Siddharth Suneel. All rights reserved.
//

import Foundation

class Constant {
    
    //MARK: API Authorisation Keys
    /*
     Need to use multiple ClientId & ClientSecret keys because quota.
     
     To use new Account change the below values of clientID & clientSecret
     */
    static let clientID = "DRJQQFBRIOVQSRYE4H0MNF03NKARCDIJKJQI3AJU14MBNFII"
    static let clientSecret = "14LB0DUPPIZX1F4IJGYGY4TRCX4FUR1OSR1CMJUYFD0UZQE0"        
    
    static let categoryId = "4bf58dd8d48988d1c4941735"
    
    static let ClientId_Key            = "client_id"
    static let ClientSecret_Key        = "client_secret"
    static let CategoryId_Key          = "categoryId"
    static let limitParam              = "limit=10"
    static let apiVersion              = "v=20180829"
    
    
    //MARK: Notifications
    @objc open static let QuotaOverNotification   = "QuotaOverNotification"
    
    //MARK: User Defaults Keys
    static let DislikedArray           = "dislikedArray"
    
    //MARK: Table View Cell Reuse Identifiers
    static let restaurantCell               = "RestaurantTableViewCellID"
    static let restaurantDetailCellID               = "RestaurantDetailCellID"
    
    //MARK: Nib Names
    static let restaurantCellNibName        = "RestaurantTableViewCell"
    static let restaurantDetailCellNibName          = "RestaurantDetailCell"
}
