//
//  ViewController.swift
//  vkSearch
//
//  Created by Alexander Kandalov on 09.07.2018.
//  Copyright © 2018 Alexander Kandalov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var searchBar: UISearchBar!
  
  var viewModel: UsersViewModeling!
  private let disposeBag = DisposeBag()
  private var profileViewModel: ProfileViewModeling!

  override func viewDidLoad() {
    super.viewDidLoad()
    setupBindings()
  }
  
  private func setupBindings() {
    
    searchBar.rx.text.orEmpty
      .bind(to: viewModel.searchText)
      .disposed(by: disposeBag)
    
    viewModel.cellModels
      .bind(to: tableView.rx.items(cellIdentifier: "UserCell", cellType: UserCell.self)) { index, model, cell in
        cell.viewModel = model
      }.disposed(by: disposeBag)
    
    tableView.rx.contentOffset
      .subscribe(onNext: { [unowned self] _ in
        if self.searchBar.isFirstResponder {
          self.searchBar.resignFirstResponder()
        }
      }).disposed(by: disposeBag)
    
    tableView.rx.itemSelected
      .map { $0.row }
      .bind(to: viewModel.cellDidSelect)
      .disposed(by: disposeBag)
    
    viewModel.presentProfile
      .subscribe(onNext: { [unowned self] viewModel in
        self.profileViewModel = viewModel
        self.performSegue(withIdentifier: "toProfile", sender: self)
      }).disposed(by: disposeBag)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "toProfile" {
      let controller = segue.destination as! ProfileViewController
      controller.viewModel = profileViewModel
    }
  }
  
}

extension SearchViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 70
  }
}

