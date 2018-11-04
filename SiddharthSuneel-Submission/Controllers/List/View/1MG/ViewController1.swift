//
//  ViewController.swift
//  SiddharthSuneel-Submission
//
//  Created by Siddharth Suneel on 24/08/18.
//  Copyright © 2018 Siddharth Suneel. All rights reserved.
//

import UIKit
import Reachability

class ViewController: BaseViewController {

    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var restaurantTableView: UITableView! {
        didSet {
            restaurantTableView.dataSource = self
            restaurantTableView.delegate = self
            restaurantTableView.tableFooterView = UIView()
            restaurantTableView.estimatedRowHeight = 100
            registerCustomCell()
        }
    }
    
    var viewModel:RestaurantListViewModel?
    
    //MARK: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupDataSource()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.filterDataSource()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name.reachabilityChanged, object: nil)
    }
    
    //MARK: Private Methods
    
    private func setup() {
        title = "list_title".localized
        restaurantTableView.estimatedRowHeight = 100.0
        addNotificationObserver()
    }
    
    private func addNotificationObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.didChangedInternetConnectionStatus(notification:)),
                                               name: Notification.Name.reachabilityChanged,
                                               object: nil)
    }
    
    private func registerCustomCell() {
        restaurantTableView.register(UINib.init(nibName: Constant.restaurantCellNibName, bundle: nil),
                                     forCellReuseIdentifier: Constant.restaurantCell)
    }
    
    @objc private func didChangedInternetConnectionStatus(notification: Notification) {
        setupDataSource()
    }
    
    private func setupDataSource() {
        hideErrorMessage()
        showActivityIndicator()
        LocationManager.sharedInstance.requestAuthorizationIfNeeded()
        LocationManager.sharedInstance.didReceiveLocation = { [weak self] (locationCoordinate) in
            guard let coordinate = locationCoordinate else {
                self?.hideActivityIndicator()
                self?.showErrorMessageLabel(text: "enable_location_message".localized)
                return
            }
            self?.viewModel = RestaurantListViewModel()
            if ReachabilityManager.sharedInstance.isReachable() {
                self?.viewModel?.requestToGetRestaurentList(lattitude: "\(String(describing: coordinate.latitude))",
                    longitude: "\(String(describing: coordinate.longitude))")
                self?.viewModel?.getDataSuccess = { () in
                    DispatchQueue.main.async {
                        if self?.viewModel?.aryVenue != nil {
                            self?.hideErrorMessage()
                        } else {
                            self?.showErrorMessageLabel(text: "no_data_available".localized)
                        }
                        self?.hideActivityIndicator()
                        self?.restaurantTableView.reloadData()
                    }
                }
            } else {
                let noInternetMessage = "no_internet_conection_title".localized + "\n\n" + "no_internet_conection_message".localized
                self?.hideActivityIndicator()
                self?.showErrorMessageLabel(text: noInternetMessage)
            }
        }
        
        viewModel?.errorWhileGettingData = { (error) in
            self.hideActivityIndicator()
            if let errorObj = error {
                CommonUtils.showOkAlertWithTitle("", message: errorObj.localizedDescription)
            }
        }
    }
    
    private func showErrorMessageLabel(text: String) {
        errorMessageLabel.text = text
        errorMessageLabel.isHidden = false
        restaurantTableView.isHidden = true
    }
    
    private func hideErrorMessage() {
        errorMessageLabel.text = ""
        errorMessageLabel.isHidden = true
        restaurantTableView.isHidden = false
    }
}

// MARK: UITableViewDataSource

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      //  return RestaurantTableViewCell.getHeightOfCell()
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        if viewModel?.aryVenue != nil {
            count = viewModel?.aryVenue?.count ?? 0
            if count == 0 {
                showErrorMessageLabel(text: "disliked_all".localized)
            }else {
                hideErrorMessage()
            }
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.restaurantCell) as! RestaurantTableViewCell
        if viewModel?.aryVenue != nil {
            guard let venueModel = viewModel?.aryVenue![indexPath.row] else {
                return UITableViewCell()
            }
            cell.setDataInCell(viewModel: venueModel)
        }
        return cell
    }
}

// MARK: UITableViewDelegate

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = RestaurantDetailViewController()
        detailVC.venueId = (viewModel?.aryVenue![indexPath.row])?.getVenueId()
        detailVC.titleText = (viewModel?.aryVenue![indexPath.row])?.getVenueName()
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
