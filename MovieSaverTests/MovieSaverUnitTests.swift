//
//  MovieSaverTests.swift
//  MovieSaverTests
//
//  Created by user on 26.12.2022.
//

import XCTest
import Swinject
import CoreData
@testable import MovieSaver

final class MovieSaverUnitTests: XCTestCase {
  
  let dependencyProvider = DependencyProvider()
  
  var moviesRepository: MoviesRepositoryProtocol?

  override func setUpWithError() throws {
    moviesRepository = dependencyProvider.container.resolve(MoviesRepositoryProtocol.self)
  }
  
  override func tearDownWithError() throws {
    moviesRepository?.deleteAll()
    moviesRepository = nil
  }
  
  func testAddMovie() throws {
    
    let testMovie = Movie(
      name: "Test Movie",
      rating: 10.0,
      releaseDate: Date(),
      link: URL(string: "https://google.com")!,
      desc: "Sample Description",
      image: UIImage(systemName: "pencil")!
    )
    
    moviesRepository?.saveMovie(testMovie)
    
    let movies = moviesRepository?.getMovies()
    
    XCTAssertTrue(movies!.contains(testMovie))
  }
}
