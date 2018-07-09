//
//  CalcAge.swift
//  vkSearch
//
//  Created by Alexander Kandalov on 09.07.2018.
//  Copyright © 2018 Alexander Kandalov. All rights reserved.
//

import UIKit

func calcAge(birthday: String) -> Int {
  let dateFormater = DateFormatter()
  dateFormater.dateFormat = "dd/MM/yyyy"
  if let birthdayDate = dateFormater.date(from: birthday) {
    let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
    let now = Date()
    let calcAge = calendar.components(.year, from: birthdayDate, to: now, options: [])
    let age = calcAge.year
    return age!
  }
  return 0
}
