//
//  ProfileViewController.swift
//  vkSearch
//
//  Created by Alexander Kandalov on 09.07.2018.
//  Copyright © 2018 Alexander Kandalov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProfileViewController: UIViewController {
  
  @IBOutlet weak var userPhoto: UIImageView!
  @IBOutlet weak var userAgeLabel: UILabel!
  @IBOutlet weak var userCityLabel: UILabel!
  
  var viewModel: ProfileViewModeling!
  var disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupBindings()
  }
  
  private func setupBindings() {
    viewModel.userProfile
      .map { $0.userName }
      .bind(to: self.rx.title)
      .disposed(by: disposeBag)
    
    viewModel.userProfile
      .map { $0.city }
      .bind(to: userCityLabel.rx.text)
      .disposed(by: disposeBag)
    
    viewModel.userProfile
      .map { $0.age }
      .bind(to: userAgeLabel.rx.text)
      .disposed(by: disposeBag)
    
    viewModel.photo
      .bind(to: userPhoto.rx.image)
      .disposed(by: disposeBag)
  }

}
