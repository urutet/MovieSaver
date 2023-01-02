//
//  ViewControllerAssembly.swift
//  MovieSaver
//
//  Created by user on 26.12.2022.
//

import Foundation
import Swinject

final class ViewControllerAssembly: Assembly {
  func assemble(container: Container) {
    container.register(MovieListViewController.self) { resolver in
      let viewController = MovieListViewController()
      
      viewController.moviesRepository = resolver.resolve(MoviesRepositoryProtocol.self)
      
      return viewController
    }
  }
}
