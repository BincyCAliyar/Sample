//
//  Extension.swift
//  MyProduct
//
//  Created by Sijo Thadathil on 14/07/21.
//

import Foundation
import UIKit

extension Array {
  init(repeating: [Element], count: Int) {
    self.init([[Element]](repeating: repeating, count: count).flatMap{$0})
  }

  func repeated(count: Int) -> [Element] {
    return [Element](repeating: self, count: count)
  }
}
