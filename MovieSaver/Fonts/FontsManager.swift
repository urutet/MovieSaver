//
//  FontsManager.swift
//  MovieSaver
//
//  Created by Yushkevich Ilya on 27.03.22.
//

import UIKit

enum FontsManager {
  static func manropeBold(ofSize size: CGFloat) -> UIFont {
    UIFont(name: "Manrope-Bold", size: size) ?? .boldSystemFont(ofSize: size)
  }
  
  static func manropeExtraBold(ofSize size: CGFloat) -> UIFont {
    UIFont(name: "Manrope-ExtraBold", size: size) ?? .systemFont(ofSize: size, weight: .heavy)
  }
  
  static func manropeExtraLight(ofSize size: CGFloat) -> UIFont {
    UIFont(name: "Manrope-ExtraLight", size: size) ?? .systemFont(ofSize: size, weight: .ultraLight)
  }
  
  static func manropeLight(ofSize size: CGFloat) -> UIFont {
    UIFont(name: "Manrope-Light", size: size) ?? .systemFont(ofSize: size, weight: .light)
  }
  
  static func manropeMedium(ofSize size: CGFloat) -> UIFont {
    UIFont(name: "Manrope-Medium", size: size) ?? .systemFont(ofSize: size, weight: .medium)
  }
  
  static func manropeRegular(ofSize size: CGFloat) -> UIFont {
    UIFont(name: "Manrope-Regular", size: size) ?? .systemFont(ofSize: size)
  }
  
  static func manropeSemiBold(ofSize size: CGFloat) -> UIFont {
    UIFont(name: "Manrope-SemiBold", size: size) ?? .systemFont(ofSize: size, weight: .semibold)
  }
}
