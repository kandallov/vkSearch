//
//  APIWorker.swift
//  vkSearch
//
//  Created by Alexander Kandalov on 09.07.2018.
//  Copyright © 2018 Alexander Kandalov. All rights reserved.
//

import SwiftyVK
import SwiftyJSON
import RxSwift

protocol APIWorking {
  func search(_ query: String, offset: Int, count: Int) -> Observable<Users>
}

final class APIWorker: APIWorking {
  
  func search(_ query: String, offset: Int, count: Int) -> Observable<Users> {
    return Observable.create { observer in
      VK.API.Users.search([.q: "\(query)", .sort: "0", .offset: "\(offset)", .count: "\(count)", .fields: "photo_100"])
        .onSuccess {
          let users = try JSONDecoder().decode(Users.self, from: $0)
          observer.onNext(users)
          observer.onCompleted()
        }
        .onError { (error) in
          observer.onError(error)
        }
        .send()
      return Disposables.create()
    }
  }

}
