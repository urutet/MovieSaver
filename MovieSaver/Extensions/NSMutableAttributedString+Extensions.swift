//
//  NSMutableAttributedString+.swift
//  MovieSaver
//
//  Created by Yushkevich Ilya on 26.01.22.
//

import UIKit

extension NSMutableAttributedString {
  func bold(_ value: String, ofSize: CGFloat) -> NSMutableAttributedString {
    let attributes: [NSAttributedString.Key: Any] = [
      .font: FontsManager.bold(ofSize: ofSize)
    ]
    self.append(NSAttributedString(string: value, attributes: attributes))
    return self
  }
  
  func normal(_ value: String, ofSize: CGFloat) -> NSMutableAttributedString {
    let attributes: [NSAttributedString.Key: Any] = [
      .font: FontsManager.regular(ofSize: ofSize)
    ]
    self.append(NSAttributedString(string: value, attributes: attributes))
    return self
  }
}
