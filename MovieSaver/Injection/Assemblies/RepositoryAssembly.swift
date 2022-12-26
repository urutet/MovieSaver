//
//  RepositoryAssembly.swift
//  MovieSaver
//
//  Created by user on 26.12.2022.
//

import Foundation
import Swinject

final class RepositoryAssembly: Assembly {
  func assemble(container: Swinject.Container) {
    container.register(MoviesRepositoryProtocol.self) { _ in CoreDataService() }
  }
}
