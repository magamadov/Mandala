//
//  UIImage+Mandala.swift
//  Mandala
//
//  Created by ZELIMKHAN MAGAMADOV on 15.08.2020.
//

import UIKit

enum ImageResource: String {
  case angry
  case confused
  case crying
  case goofy
  case happy
  case meh
  case sad
  case sleepy
}

extension UIImage {
  convenience init(resource: ImageResource) {
    self.init(named: resource.rawValue)!
  }
}
