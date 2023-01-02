//
//  IOService.swift
//  MovieSaver
//
//  Created by Yushkevich Ilya on 10.04.22.
//

import Foundation
import CoreData

protocol MoviesRepositoryProtocol {
  func saveMovie(_ movie: Movie)
  func getMovies() -> [Movie]?
  func deleteMovie(name: String)
  func deleteAll()
}
