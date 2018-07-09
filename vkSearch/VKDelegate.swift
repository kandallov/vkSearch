//
//  VKDelegate.swift
//  vkSearch
//
//  Created by Alexander Kandalov on 09.07.2018.
//  Copyright © 2018 Alexander Kandalov. All rights reserved.
//

import UIKit
import SwiftyVK

class VKDelegate: SwiftyVKDelegate {
  
  let appId = "6625993"
  let scopes: Scopes = []
  
  init() {
    VK.setUp(appId: appId, delegate: self)
  }
  
  func vkNeedsScopes(for sessionId: String) -> Scopes {
    return scopes
  }
  
  func vkNeedToPresent(viewController: VKViewController) {
    if let rootController = UIApplication.shared.keyWindow?.rootViewController {
      rootController.present(viewController, animated: true)
    }
  }
  
  func vkTokenCreated(for sessionId: String, info: [String : String]) {
    // Called when user grants access and SwiftyVK gets new session token
    // Can be used to run SwiftyVK requests and save session data
    print("token created in session \(sessionId) with info \(info)")
  }
  
  func vkTokenUpdated(for sessionId: String, info: [String : String]) {
    // Called when existing session token has expired and successfully refreshed
    // You don't need to do anything special here
    print("token updated in session \(sessionId) with info \(info)")
  }
  
  func vkTokenRemoved(for sessionId: String) {
    // Called when user was logged out
    // Use this method to cancel all SwiftyVK requests and remove session data
    print("token removed in session \(sessionId)")
  }
}
