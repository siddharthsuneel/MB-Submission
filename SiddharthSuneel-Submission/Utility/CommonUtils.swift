//
//  CommonUtils.swift
//  SiddharthSuneel-Submission
//
//  Created by Siddharth Suneel on 26/08/18.
//  Copyright © 2018 Siddharth Suneel. All rights reserved.
//

import Foundation
import UIKit

@objc open class CommonUtils: NSObject {
    
    //MARK: Alert Methods
    /**
     This function is used to show the alert message with title and message string.
     - parameter title : title string
     - parameter message : message string
     */
    class func showOkAlertWithTitle(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "ok_button_title".localized,
                                      style: UIAlertActionStyle.default,
                                      handler: { action in
            switch action.style{
            case .default:
                debugPrint("default")
                
            case .cancel:
                debugPrint("cancel")
                
            case .destructive:
                debugPrint("destructive")
            }
            
        }))
        self.showAlert(alert)
    }
    
    /**
     This function is used to show the alert message with title, message string and to open app settings .
     - parameter title : title string
     - parameter message : message string
     - parameter settings : setting message string
     */
    class func showOkAlertWithTitle(_ title: String, message: String, settings: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "ok_button_title".localized,
                                      style: UIAlertActionStyle.default,
                                      handler: { action in
            switch action.style{
            case .default:
                debugPrint("default")
            case .cancel:
                debugPrint("cancel")
            case .destructive:
                debugPrint("destructive")
            }
        }))
        alert.addAction(UIAlertAction(title: settings, style: UIAlertActionStyle.default, handler: { action in
            switch action.style{
            case .default:
                UIApplication.shared.open(NSURL.init(string: UIApplicationOpenSettingsURLString)! as URL,
                                          options: [:],
                                          completionHandler: { (success) in
                })
                debugPrint("default")
            case .cancel:
                debugPrint("cancel")
            case .destructive:
                debugPrint("destructive")
            }
        }))
        self.showAlert(alert)
    }
    
    /**
     Common function to show alert
     - parameter alert : UIAlertController object to show
     */
    class func showAlert(_ alert: UIAlertController) {
        let alertViewController = self.visibleViewController()
        alertViewController.present(alert, animated: true, completion: nil)
    }
    
    /**
     This function is used to get current visible controller
     - returns: UIViewController
     */
    class func visibleViewController() -> UIViewController {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let rootVC = appDelegate.window?.rootViewController
        return self.findVisibleViewController(vc: rootVC!)
    }
    
    /**
     This function is used to find current visible controller on the window
     - parameter UIViewController : view controller
     - returns: UIViewController
     */
    class func findVisibleViewController(vc : UIViewController) -> UIViewController {
        
        if (vc.presentedViewController != nil) {
            return self.findVisibleViewController(vc: vc.presentedViewController!)
        } else if vc.isKind(of: UISplitViewController.self) {
            let svc = vc as! UISplitViewController
            if svc.viewControllers.count>0 {
                return self.findVisibleViewController(vc: svc.viewControllers.last!)
            } else {
                return vc
            }
        } else if vc.isKind(of: UINavigationController.self) {
            let nvc = vc as! UINavigationController
            if nvc.viewControllers.count>0 {
                return self.findVisibleViewController(vc: nvc.topViewController!)
            } else {
                return vc
            }
        } else if vc.isKind(of: UITabBarController.self) {
            let tvc = vc as! UITabBarController
            if (tvc.viewControllers?.count)!>0 {
                return self.findVisibleViewController(vc: tvc.selectedViewController!)
            } else {
                return vc
            }
        } else {
            return vc
        }
    }
    
    //MARK: User Default Methods
    
    @objc open class func saveDislikeVenue(venueId:String) {
        guard var arr = UserDefaults.standard.value(forKey: Constant.DislikedArray) as? [String]
            else {
                UserDefaults.standard.setValue([venueId], forKey: Constant.DislikedArray)
                UserDefaults.standard.synchronize()
                return
        }
        if !(arr.contains(venueId)) {
            arr.append(venueId)
            UserDefaults.standard.setValue(arr, forKey: Constant.DislikedArray)
            UserDefaults.standard.synchronize()
        }
    }
    
    func removeDislikedVenue(id:String) {
        guard var arr = UserDefaults.standard.value(forKey: Constant.DislikedArray) as? [String] else { return }
        var objIndex = -1
        for i in 0..<arr.count {
            if arr[i] == id {
                objIndex = i
                break
            }
        }
        if objIndex > 0 {
            arr.remove(at: objIndex)
            UserDefaults.standard.setValue(arr, forKey: Constant.DislikedArray)
            UserDefaults.standard.synchronize()
        }
    }
}
