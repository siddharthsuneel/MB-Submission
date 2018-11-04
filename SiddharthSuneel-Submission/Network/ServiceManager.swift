//
//  ServiceManager.swift
//  SiddharthSuneel-Submission
//
//  Created by Siddharth Suneel on 24/08/18.
//  Copyright © 2018 Siddharth Suneel. All rights reserved.
//

import Foundation

open class ServiceManager: NSObject {
    
    //MARK: Shared Instance
    @objc static let sharedInstance = ServiceManager()
    private override init() {}
    
    func getData(lattitude:String, longitude:String, completionHandler:@escaping (ResponseModel?,Error?)->()) {
        let queryParam:String = "?ll=\(lattitude),\(longitude)&\(Constant.CategoryId_Key)=\(Constant.categoryId)&\(Constant.limitParam)&\(Constant.ClientId_Key)=\(Constant.clientID)&\(Constant.ClientSecret_Key)=\(Constant.clientSecret)&\(Constant.apiVersion)"
        
        let requestURLString =  APIPath.baseURL + APIPath.getVenues + queryParam
        
        callAPI(httpMethod: "GET", requestURL: requestURLString) { (response, error) in
            guard error == nil else {
                completionHandler(nil, error)
                return
            }
            guard let responseData = response as? Data else {
                completionHandler(nil,error)
                return
            }
            do{
                let model = try JSONDecoder().decode(ResponseModel.self, from: responseData)
                completionHandler(model,nil)
            } catch let error {
                completionHandler(nil,error)
            }
        }
    }

//    @objc open func getRestaurantDetailData(id:String, completionHandler:@escaping (RestaurantDetailModel?, Error?)->()) {
//        let queryParam:String = "?\(Constant.ClientId_Key)=\(Constant.clientID)&\(Constant.ClientSecret_Key)=\(Constant.clientSecret)&\(Constant.apiVersion)"
//
//        let requestURLString =  APIPath.baseURL + APIPath.getVenuesDetail + "/\(id)" + queryParam
//        callAPI(httpMethod: "GET", requestURL: requestURLString) { (response, error) in
//            guard error == nil else {
//                completionHandler(nil, error)
//                return
//            }
//            guard let responseData = response as? Data else {
//                completionHandler(nil,error)
//                return
//            }
//            do{
//                let model = try JSONDecoder().decode(RestaurantDetailModel.self, from: responseData)
//                completionHandler(model,nil)
//            } catch let error {
//                completionHandler(nil,error)
//            }
//        }
//    }
    
//    @objc open func getPhotoData(id:String, completionHandler:@escaping (PhotoDataResponseModel?, Error?)->()) {
//        let queryParam:String = "?\(Constant.ClientId_Key)=\(Constant.clientID)&\(Constant.ClientSecret_Key)=\(Constant.clientSecret)&\(Constant.apiVersion)"
//
//        let requestURLString =  APIPath.baseURL + APIPath.getVenuesDetail + "/\(id)" + "/photos" + queryParam
//        callAPI(httpMethod: "GET", requestURL: requestURLString) { (response, error) in
//            guard error == nil else {
//                completionHandler(nil, error)
//                return
//            }
//            guard let responseData = response as? Data else {
//                completionHandler(nil,error)
//                return
//            }
//            do{
//                let model = try JSONDecoder().decode(PhotoDataResponseModel.self, from: responseData)
//                completionHandler(model,nil)
//            } catch let error {
//                completionHandler(nil,error)
//            }
//        }
//    }
    
    private func callAPI(httpMethod:String, requestURL:String, completionHandler:@escaping (AnyObject?, Error?)->()) {
        
        let url = URL(string: requestURL)!
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = httpMethod
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        let task = session.dataTask(with: request as URLRequest) { [weak self] (data, response, error) in
            guard let _: Data = data, let _: URLResponse = response, error == nil else {
                debugPrint("*****error")
                completionHandler(nil, error)
                return
            }
            let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            debugPrint("*****Response data for Request ------- \(url) ---------: \(String(describing: dataString))")
            self?.handleQuotaOverIssue(responseString: dataString!)
            completionHandler(data! as AnyObject,nil)
        }
        task.resume()
    }
    
    private func handleQuotaOverIssue(responseString:NSString) {
        let quotaOverErrorString = "\"code\":429"
        if responseString.contains(quotaOverErrorString) {
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: Notification.Name(rawValue: Constant.QuotaOverNotification), object: nil)
            }
        }
    }
}
