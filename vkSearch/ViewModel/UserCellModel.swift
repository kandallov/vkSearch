//
//  UserCellModel.swift
//  vkSearch
//
//  Created by Alexander Kandalov on 09.07.2018.
//  Copyright © 2018 Alexander Kandalov. All rights reserved.
//

import RxSwift

protocol UserCellModeling {
  var firstName: String { get }
  var lastName: String { get }
  var photo: Observable<UIImage> { get }
}

class UserCellModel: UserCellModeling {
  let firstName: String
  let lastName: String
  let photo: Observable<UIImage>
  
  init(apiwoker: APIWorking, imageUrl: String, firstName: String, lastName: String) {
    let placeholder = #imageLiteral(resourceName: "userPlaceholder50")
    self.photo = Observable.just(placeholder)
      .concat(apiwoker.photoGet(imageUrl))
      .observeOn(MainScheduler.instance)
      .catchErrorJustReturn(placeholder)
    self.firstName = firstName
    self.lastName = lastName
  }
}
