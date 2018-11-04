//
//  RestaurantListViewModel.swift
//  SiddharthSuneel-Submission
//
//  Created by Siddharth Suneel on 24/08/18.
//  Copyright © 2018 Siddharth Suneel. All rights reserved.
//

import Foundation

class RestaurantListViewModel {
    
    var aryVenue:[VenuesViewModel]?
    var getDataSuccess : (()->())?
    var errorWhileGettingData : ((Error?)->())?
    
    func requestToGetRestaurentList(lattitude:String, longitude:String){
        ServiceManager.sharedInstance.getData(lattitude: lattitude, longitude: longitude) { [weak self] (model,error) in
            debugPrint("model is : \(String(describing: model))")
            if let venues = model?.response?.venues {
                self?.aryVenue = venues.map {VenuesViewModel(modelObj: $0) }
                self?.filterDataSource()
            } else {
                self?.errorWhileGettingData!(error)
            }
        }
    }
    
    func filterDataSource() {
        guard let arr = UserDefaults.standard.value(forKey: Constant.DislikedArray) as? [String] else {
                self.getDataSuccess?()
                return
        }
        
        self.aryVenue = self.aryVenue?.filter({ (venueViewModel) -> Bool in
            if arr.contains(venueViewModel.getVenueId()) {
                return false
            }
            return true
        })
        self.getDataSuccess?()
    }
}
