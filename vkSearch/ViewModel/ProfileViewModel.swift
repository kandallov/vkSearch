//
//  ProfileViewModel .swift
//  vkSearch
//
//  Created by Alexander Kandalov on 09.07.2018.
//  Copyright © 2018 Alexander Kandalov. All rights reserved.
//

import RxSwift

protocol ProfileViewModeling {
  // MARK: - Output
  var userProfile: Observable<UserProfileModel> { get }
  var photo: Observable<UIImage> { get }
}

class ProfileViewModel: ProfileViewModeling {
  // MARK: - Output
  let userProfile: Observable<UserProfileModel>
  let photo: Observable<UIImage>
  
  init(apiworker: APIWorking, currentUser: User) {
    let currentUserID = "\(currentUser.id)"
    let searchResult = Observable.just(UserProfile.placeholder)
      .flatMapLatest { _ in
        return apiworker.userGet(currentUserID)
          .catchErrorJustReturn(UserProfile.placeholder)
      }
      .observeOn(MainScheduler.instance)
      .startWith(UserProfile.empty)
      .share(replay: 1)
    
    userProfile = searchResult
      .map { user in
        UserProfileModel(userProfile: user)
    }
    
    let photoPlaceholder = #imageLiteral(resourceName: "userPlaceholder100")
    photo = searchResult
      .map { user in
        let imageUrl = user.photo_200
        return imageUrl
      }
      .flatMapLatest { imageUrl in
        return apiworker.photoGet(imageUrl)
          .catchErrorJustReturn(photoPlaceholder)
    }
  }
}
