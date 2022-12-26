//
//  ViewModelAssembly.swift
//  MovieSaver
//
//  Created by user on 26.12.2022.
//

import Foundation
import Swinject

final class ViewModelAssembly: Assembly {
  func assemble(container: Swinject.Container) {
    container.register(AddMovieViewModel.self) { resolver in
      let viewModel = AddMovieViewModel()
      
      viewModel.moviesRepository = resolver.resolve(MoviesRepositoryProtocol.self)
      
      return viewModel
    }
  }
}
