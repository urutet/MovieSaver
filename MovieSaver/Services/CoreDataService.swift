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
    static let entityName = "Movie"
    static let namePredicate = "%K =%@"
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
  
  private init() { }
  
  func saveMovie(_ movie: Movie) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    
    let managedContext = appDelegate.persistentContainer.viewContext
    
    let entity = NSEntityDescription.entity(forEntityName: Constants.entityName, in: managedContext)!
    
    let movieEntity = NSManagedObject(entity: entity, insertInto: managedContext)
    
    movieEntity.setValue(movie.name, forKey: MovieKeys.name.rawValue)
    movieEntity.setValue(movie.rating, forKey: MovieKeys.rating.rawValue)
    movieEntity.setValue(movie.releaseDate, forKey: MovieKeys.releaseDate.rawValue)
    movieEntity.setValue(movie.youTubeLink, forKey: MovieKeys.youTubeLink.rawValue)
    movieEntity.setValue(movie.desc, forKey: MovieKeys.desc.rawValue)
    movieEntity.setValue(movie.imageData, forKey: MovieKeys.imageData.rawValue)
    
    do {
      try managedContext.save()
    } catch let error as NSError {
      print("Error - \(error)")
    }
  }
  
  func getMovies() -> [Movie]? {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
    let managedContext = appDelegate.persistentContainer.viewContext
    
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Constants.entityName)
    
    do {
      let objects = try managedContext.fetch(fetchRequest)
      var movies = [Movie]()
      for object in objects {
        guard
          let name = object.value(forKey: MovieKeys.name.rawValue) as? String,
          let rating = object.value(forKey: MovieKeys.rating.rawValue) as? Double,
          let releaseDate = object.value(forKey: MovieKeys.releaseDate.rawValue) as? Date,
          let link = object.value(forKey: MovieKeys.youTubeLink.rawValue) as? URL,
          let desc = object.value(forKey: MovieKeys.desc.rawValue) as? String,
          let imageData = object.value(forKey: MovieKeys.imageData.rawValue) as? Data
        else { return nil }
        var movie = Movie(
          name: name,
          rating: rating,
          releaseDate: releaseDate,
          link: link,
          desc: desc,
          image: UIImage(data: imageData) ?? UIImage.add
        )
        movie.image = UIImage(data: imageData) ?? UIImage.add
        movies.append(movie)
      }
      return movies
    } catch let error as NSError {
      print("Error - \(error)")
    }
    
    return nil
  }
  
  func deleteMovie(name: String) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Constants.entityName)
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
