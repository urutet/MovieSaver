//
//  Navigation.swift
//  MovieSaver
//
//  Created by Yushkevich Ilya on 10.04.22.
//

import UIKit

enum Destination {
  case addMovie((Movie) -> Void)
  case movieList
  case movieDetail(Movie)
  case baseChangeInfo(ChangeInfoViewControllerInputType, (ChangeInfoViewControllerOutputType) -> Void)
}

final class Navigator: NavigationServiceProtocol, AppDependencyProvider {
  // MARK: - Properties
  // MARK: Public
  static var instance = Navigator()
  
  // MARK: Private
  weak var navigationController: UINavigationController?
  
  // MARK: - API
  func navigate(destination: Destination) {
    let vc = makeViewController(for: destination)
    navigationController?.pushViewController(vc, animated: true)
  }
  
  func pop() {
    navigationController?.popViewController(animated: true)
  }
  
  // MARK: - Helpers
  private func makeViewController(for destination: Destination) -> UIViewController {
    switch destination {
    case .addMovie(let eventHandler):
      let viewModel = Navigator.container.resolve(AddMovieViewModel.self)!
      viewModel.eventHandler = eventHandler
      let addMovieVC = AddMovieViewController()
      addMovieVC.viewModel = viewModel
      
      return addMovieVC
    case .baseChangeInfo(let inputType, let outputHandler):
      let changeInfoVC = BaseChangeInfoViewController()
      changeInfoVC.inputControllerType = inputType
      changeInfoVC.outputHandler = outputHandler
      
      return changeInfoVC
    case .movieDetail(let movie):
      let movieDetailVC = MovieDetailViewController()
      movieDetailVC.setMovie(movie)
      
      return movieDetailVC
    case .movieList:
      return MovieListViewController()
    }
  }
}
