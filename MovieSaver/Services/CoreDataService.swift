//
//  CoreDataService.swift
//  MovieSaver
//
//  Created by Yushkevich Ilya on 4.04.22.
//

import UIKit
import CoreData

final class CoreDataService: IOService {
  private enum Constants {
    static let entityName = "MovieMO"
    static let namePredicate = "%K = %@"
  }
  
  private enum MovieKeys: String {
    case name
    case rating
    case releaseDate
    case youTubeLink
    case desc
    case imageData
  }
  static let instance = CoreDataService()
  
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "MovieModel")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()
  
  func saveContext () {
    let context = persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
  
  private init() { }
  
  func saveMovie(_ movie: Movie) {
    let managedContext = persistentContainer.viewContext
    
    let entity = NSEntityDescription.entity(forEntityName: Constants.entityName, in: managedContext)!
    
    MovieMO(movie: movie, entity: entity, context: managedContext)
    
    do {
      try managedContext.save()
    } catch let error as NSError {
      print("Error - \(error)")
    }
  }
  
  func getMovies() -> [Movie]? {
    let managedContext = persistentContainer.viewContext
    
    let fetchRequest = NSFetchRequest<MovieMO>(entityName: Constants.entityName)
    
    do {
      let moviesMO = try managedContext.fetch(fetchRequest)
      let movies = moviesMO.map{ Movie(movieMO: $0) }
      return movies
    } catch let error as NSError {
      print("Error - \(error)")
    }
    
    return nil
  }
  
  func deleteMovie(name: String) {
    let managedContext = persistentContainer.viewContext
    
    let fetchRequest = NSFetchRequest<MovieMO>(entityName: Constants.entityName)
    fetchRequest.predicate = NSPredicate(format: Constants.namePredicate, MovieKeys.name.rawValue, name)
    
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
