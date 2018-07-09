//
//  UserCell.swift
//  vkSearch
//
//  Created by Alexander Kandalov on 09.07.2018.
//  Copyright © 2018 Alexander Kandalov. All rights reserved.
//

import RxSwift

class UserCell: UITableViewCell {
  
  @IBOutlet weak var userName: UILabel!
  @IBOutlet weak var userPhoto: UIImageView!
  
  private var disposeBag: DisposeBag? = DisposeBag()
  
  var viewModel: UserCellModeling? {
    didSet {
      let disposeBag = DisposeBag()
      guard let viewModel = viewModel else { return }
      
      viewModel.photo
        .bind(to: userPhoto.rx.image)
        .disposed(by: disposeBag)
      
      userName.text = "\(viewModel.firstName) \(viewModel.lastName)"
      
      self.disposeBag = disposeBag
    }
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    viewModel = nil
    disposeBag = nil
  }
  
}
