//
//  AppDependencyProvider.swift
//  MovieSaver
//
//  Created by user on 26.12.2022.
//

import Swinject

protocol AppDependencyProvider {
  
}

extension AppDependencyProvider {
  static var assembler: Assembler {
    return (UIApplication.shared.delegate as? AppDelegate)!.dependencyProvider.assembler
  }
  
  static var container: Container {
    return (UIApplication.shared.delegate as? AppDelegate)!.dependencyProvider.container
  }
}
