//
//  File.swift
//  MovieSaver
//
//  Created by Yushkevich Ilya on 9.01.22.
//

import Foundation
import UIKit

extension UIView {
  func roundCorners(corners: UIRectCorner, radius: CGFloat) {
       let path = UIBezierPath(roundedRect: bounds,
                               byRoundingCorners: corners,
                               cornerRadii: CGSize(width: radius, height: radius)
       )
       let mask = CAShapeLayer()
       mask.path = path.cgPath
       layer.mask = mask
   }
}
