//
//  Navigation.swift
//  MovieSaver
//
//  Created by Yushkevich Ilya on 10.04.22.
//

import Foundation
import UIKit

enum Destination {
  case addMovie((Movie) -> Void)
  case movieList
  case movieDetail(Movie)
  case baseChangeInfo(ChangeInfoViewControllerInputType, (ChangeInfoViewControllerOutputType) -> Void)
}

@MainActor
final class Navigator {

  // MARK: - Properties
  // MARK: Public
  static let instance = Navigator(navigationController: UINavigationController(rootViewController: MovieListViewController()))
  // MARK: Private
  private(set) weak var navigationController: UINavigationController?
  
  // MARK: - Lifecycle
  private init(navigationController: UINavigationController) {
    guard self.navigationController == nil else { return }
    self.navigationController = navigationController
  }
  
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
      let addMovieVC = AddMovieViewController()
      addMovieVC.viewModel = AddMovieViewModel()
      addMovieVC.viewModel.eventHandler = eventHandler
      
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

extension Navigator: NSCopying {

    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
