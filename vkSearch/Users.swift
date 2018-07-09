//
//  Users.swift
//  vkSearch
//
//  Created by Alexander Kandalov on 09.07.2018.
//  Copyright © 2018 Alexander Kandalov. All rights reserved.
//

struct Users: Decodable {
  var items: [User]
  var count: Int
}

struct User: Decodable {
  var id: Int
  var first_name: String
  var last_name: String
  var photo_100: String
}
