//
//  CircleView.swift
//  vkSearch
//
//  Created by Alexander Kandalov on 09.07.2018.
//  Copyright © 2018 Alexander Kandalov. All rights reserved.
//

import UIKit

class CircleImageView: UIImageView {
  override func awakeFromNib() {
    super.awakeFromNib()
    self.layer.cornerRadius = self.frame.width / 2
    self.clipsToBounds = true
  }
  
}

class UserBackgroundView: UIView {
  override func awakeFromNib() {
    super.awakeFromNib()
    self.layer.cornerRadius = 7
    self.layer.borderColor = UIColor.gray.withAlphaComponent(0.4).cgColor
    self.layer.borderWidth = 0.6
    self.clipsToBounds = true
  }
}
