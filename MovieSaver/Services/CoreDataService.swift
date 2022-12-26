//
//  CoreDataService.swift
//  MovieSaver
//
//  Created by Yushkevich Ilya on 4.04.22.
//

import UIKit
import CoreData

final class CoreDataService: MoviesRepositoryProtocol {
  private enum Constants {
    static let entityName = "MovieMO"
    static let namePredicate = "name == %@"
    static let containerName = "MovieModel"
  }
  
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: Constants.containerName)
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()
  
  private func convertToMovieMO(movie: Movie, context: NSManagedObjectContext) -> MovieMO {
    let movieMO = MovieMO(context: context)
    
    movieMO.name = movie.name
    movieMO.rating = movie.rating
    movieMO.releaseDate = movie.releaseDate
    movieMO.youTubeLink = movie.youTubeLink
    movieMO.desc = movie.desc
    movieMO.imageData = movie.imageData
    
    return movieMO
  }
  
  private func convertToMovie(movieMO: MovieMO) -> Movie? {
    guard
      let name = movieMO.name,
      let releaseDate = movieMO.releaseDate,
      let link = movieMO.youTubeLink,
      let desc = movieMO.desc,
      let imageData = movieMO.imageData,
      let image = UIImage(data: imageData)
    else { return nil }
    return Movie(
      name: name,
      rating: movieMO.rating,
      releaseDate: releaseDate,
      link: link,
      desc: desc,
      image: image
    )
  }
  
  func saveMovie(_ movie: Movie) {
    let managedContext = persistentContainer.viewContext
    
    let managedMovie = convertToMovieMO(movie: movie, context: managedContext)
    
    do {
      try managedContext.save()
    } catch let error as NSError {
      print("Error - \(error)")
    }
  }
  
  func getMovies() -> [Movie]? {
    let managedContext = persistentContainer.viewContext
    
    let fetchRequest = MovieMO.fetchRequest()
    
    do {
      let moviesMO = try managedContext.fetch(fetchRequest)
      let movies = moviesMO.compactMap{ convertToMovie(movieMO: $0) }
      return movies
    } catch let error as NSError {
      print("Error - \(error)")
    }
    return nil
  }
  
  func deleteMovie(name: String) {
    let managedContext = persistentContainer.viewContext
    
    let fetchRequest = MovieMO.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: Constants.namePredicate, name)
    
    do {
      let objects = try managedContext.fetch(fetchRequest)
      for object in objects {
        managedContext.delete(object)
      }
      try managedContext.save()
    } catch let error as NSError {
      print("Error - \(error)")
    }
  }
}
