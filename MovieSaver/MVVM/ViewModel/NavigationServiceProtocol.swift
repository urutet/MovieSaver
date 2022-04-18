//
//  NavigationServiceProtocol.swift
//  MovieSaver
//
//  Created by Yushkevich Ilya on 11.04.22.
//

import UIKit

protocol NavigationServiceProtocol {
  var navigationController: UINavigationController? { get }
  
  func navigate(destination: Destination)
  func pop()
}
