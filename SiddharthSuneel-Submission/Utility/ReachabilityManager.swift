//
//  Extensions.swift
//  SiddharthSuneel-Submission
//
//  Created by Siddharth Suneel on 25/08/18.
//  Copyright © 2018 Siddharth Suneel. All rights reserved.
//

import UIKit
import Reachability

class ReachabilityManager: NSObject {

  static let sharedInstance = ReachabilityManager()
  
  func isReachable() -> Bool {
    if let reachability = self.reachability() {
      return reachability.connection != .none
    }
    return true
  }

  // MARK: - Notifier
  func startReachabilityNotifier() {
    if let reachability = self.reachability() {
      NotificationCenter.default.addObserver(self,
                                             selector: #selector(reachabilityChanged(note:)),
                                             name: Notification.Name.reachabilityChanged,
                                             object: reachability)
      do {
        try reachability.startNotifier()
      } catch {
        debugPrint("could not start reachability notifier")
      }
    }
  }
  
  func stopReachabilityNotifier() {
    if let reachability = self.reachability() {
      reachability.stopNotifier()
      NotificationCenter.default.removeObserver(self, name: Notification.Name.reachabilityChanged, object: nil)
    }
  }

  @objc func reachabilityChanged(note: Notification) {
    
    guard let reachability = note.object as? Reachability else { return }
    
    if reachability.connection != .none {
      if reachability.connection == .wifi {
        debugPrint("Reachable via WiFi")
      } else {
        debugPrint("Reachable via Cellular")
      }
    } else {
      debugPrint("Network not reachable")
    }
  }
  
  // MARK: - Private
  
  /// allocate Reachability class as singleton
  private func reachability() -> Reachability? {
    
    if Temp.object != nil {
      return Temp.object
    }
    
    if let reachability = Reachability() {
      Temp.object = reachability
      return reachability
    }
    
    return nil
  }
  
  struct Temp {
    static var object: Reachability?
  }

}
