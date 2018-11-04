//
//  BaseViewController.swift
//  SiddharthSuneel-Submission
//
//  Created by Siddharth Suneel on 28/08/18.
//  Copyright © 2018 Siddharth Suneel. All rights reserved.
//

import UIKit

@objc open class BaseViewController: UIViewController {

    var activityIndicator: UIActivityIndicatorView?
    
    //MARK: Life Cycle Methods
    override open func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Private Methods
    private func setup() {
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        activityIndicator?.center = self.view.center
        activityIndicator?.color = UIColor.red
        activityIndicator?.hidesWhenStopped = true
        guard let indicator = activityIndicator else {
                debugPrint("Found nil while unwrapping optional.")
                return
        }
        UIApplication.shared.keyWindow?.addSubview(indicator)
    }

    //MARK: Public Methods
    @objc open func hideActivityIndicator() {
        activityIndicator?.stopAnimating()
    }
    
    @objc open func showActivityIndicator() {
        activityIndicator?.startAnimating()
        activityIndicator?.isHidden = false
    }
}
