//
//  UserProfile.swift
//  vkSearch
//
//  Created by Alexander Kandalov on 09.07.2018.
//  Copyright © 2018 Alexander Kandalov. All rights reserved.
//

struct UserProfile: Decodable {
  var id: Int
  var first_name: String
  var last_name: String
  var photo_200: String
  var bdate: String?
  var city: City?
  
  static let placeholder = UserProfile(id: 0, first_name: "No information", last_name: "", photo_200: "photo_200", bdate: "", city: City(id: 0, title: "city is hidden"))
  static let empty = UserProfile(id: 0, first_name: "", last_name: "", photo_200: "", bdate: "empty", city: City(id: 0, title: ""))
  
}

struct City: Decodable {
  var id: Int?
  var title: String?
}
