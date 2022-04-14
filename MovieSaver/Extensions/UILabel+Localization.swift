//
//  UILabel+Localization.swift
//  MovieSaver
//
//  Created by Yushkevich Ilya on 14.04.22.
//

import UIKit

protocol Localizable {
    var localized: String { get }
}

extension String: Localizable {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

protocol XIBLocalizable {
    var xibLocKey: String? { get set }
}

extension UILabel: XIBLocalizable {
  @IBInspectable var xibLocKey: String? {
          get { return nil }
          set(key) {
              text = key?.localized
          }
      }
}
