//
//  UsersViewModel.swift
//  vkSearch
//
//  Created by Alexander Kandalov on 09.07.2018.
//  Copyright © 2018 Alexander Kandalov. All rights reserved.
//

import RxSwift

protocol UsersViewModeling {
  // MARK: - Input
  var searchText: PublishSubject<String> { get }
  var cellDidSelect: PublishSubject<Int> { get }
  
  // MARK: - Output
  var cellModels: Observable<[UserCellModeling]> { get }
}

class UsersViewModel: UsersViewModeling {
  // MARK: - Input
  let searchText: PublishSubject<String> = PublishSubject<String>()
  let cellDidSelect: PublishSubject<Int> = PublishSubject<Int>()
  
  // MARK: - Output
  let cellModels: Observable<[UserCellModeling]>
  
  init(apiworker: APIWorking) {
    
    let searchResults = searchText
      .throttle(0.3, scheduler: MainScheduler.instance)
      .distinctUntilChanged()
      .flatMapLatest { query in
        apiworker.search(query, offset: 0, count: 30)
          .catchErrorJustReturn(Users(items: [], count: 0))
      }.observeOn(MainScheduler.instance)
      .startWith(Users(items: [], count: 0))
      .share(replay: 1)
    
    print(searchResults)
    
    cellModels = searchResults.map { userSearch in
      userSearch.items.map { user in
        UserCellModel(apiwoker: apiworker, imageUrl: user.photo_100, firstName: user.first_name, lastName: user.last_name)
      }
    }
    
  }
}
