//
//  DependencyProvider.swift
//  MovieSaver
//
//  Created by user on 26.12.2022.
//

import Foundation
import Swinject

final class DependencyProvider {
  let container = Container()
  let assembler: Assembler
  
  init() {
    assembler = Assembler([
      RepositoryAssembly(),
      ViewModelAssembly(),
      ViewControllerAssembly()
    ], container: container)
  }
}
