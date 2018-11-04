//
//  RestaurantListModel.swift
//  SiddharthSuneel-Submission
//
//  Created by Siddharth Suneel on 24/08/18.
//  Copyright © 2018 Siddharth Suneel. All rights reserved.
//

import Foundation

@objc open class ResponseModel: NSObject, Codable {
    var response:RestaurantListModel?
}

@objc class RestaurantListModel: NSObject, Codable {
    var venues:[Venues]?
}

@objc class Venues: NSObject, Codable {
    var id:String = ""
    var name:String?
    var referralId:String?
    var categories:[Categories]?
    var hasPerk:Bool?
    var location: Location?
}

@objc class Categories: NSObject, Codable {
    var id:String?
    var name:String?
    var pluralName:String?
    var shortName:String?
    var icon:Icon?
    var lat:Bool?
}

@objc class Icon: NSObject, Codable {
    var prefix:String?
    var suffix:String?
}

@objc class LabeledLatLngs: NSObject, Codable {
    var label:String?
    
    var lat:Double?
    var lng:Double?
}

@objc class Location: NSObject, Codable {
    var address:String?
    var postalCode:String?
    var cc:String?
    var city:String?
    var state:String?
    var country:String?
    
    var lat:Double?
    var lng:Double?
    var distance:Double?
    
    var formattedAddress:[String]?
    
    var labeledLatLngs:[LabeledLatLngs]?
}
