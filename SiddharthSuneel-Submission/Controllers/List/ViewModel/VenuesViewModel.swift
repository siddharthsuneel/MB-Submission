//
//  VenuesViewModel.swift
//  SiddharthSuneel-Submission
//
//  Created by Siddharth Suneel on 28/08/18.
//  Copyright © 2018 Siddharth Suneel. All rights reserved.
//

import Foundation

class VenuesViewModel {
    
    let venue:Venues
    
    init(modelObj:Venues) {
        self.venue = modelObj
    }
    
    func getVenueId() -> String {
        return venue.id
    }
    
    func getVenueName() -> String {
        return venue.name ?? "name_not_available".localized
    }
    
    func getVenueDistance() -> String {
        var distanceText = ""
        if let distance = venue.location?.distance {
            distanceText = "\(distance / 1000) miles"
        }else {
            distanceText = "0 miles"
        }
        return distanceText
    }
    
    func getVenueAddress() -> String {
        var fullAddress = " "
        venue.location?.formattedAddress?.forEach({ (addressSplit) in
            if fullAddress != " " {
                fullAddress = fullAddress + " " + addressSplit
            }else {
                fullAddress = addressSplit
            }
        })
        return fullAddress
    }
}
