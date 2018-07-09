//
//  UserProfileModel.swift
//  vkSearch
//
//  Created by Alexander Kandalov on 09.07.2018.
//  Copyright © 2018 Alexander Kandalov. All rights reserved.
//

import UIKit

protocol UserProfileModeling {
  var userName: String { get }
  var city: String { get }
  var age: String { get }
}

class UserProfileModel {
  let userName: String
  let city: String
  let age: String
  
  init(userProfile: UserProfile) {
    self.userName = "\(userProfile.first_name) \(userProfile.last_name)"
    
    self.city = userProfile.city?.title ?? "city is hidden"
    
    if userProfile.bdate == "empty" {
      self.age = ""
    } else {
      let ageCalc = calcAge(birthday: userProfile.bdate ?? "")
      if ageCalc != 0 { self.age = "\(ageCalc) yaers old"} else { self.age = "age is hidden" }
    }
  }
}

