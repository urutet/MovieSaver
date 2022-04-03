//
//  CoreDataService.swift
//  MovieSaver
//
//  Created by Yushkevich Ilya on 4.04.22.
//

import UIKit
import CoreData

final class CoreDataService {
  static let instance = CoreDataService()
  
  private init() { }
  
  func saveMovie(_ movie: Movie) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    
    let managedContext = appDelegate.persistentContainer.viewContext
    
    let entity = NSEntityDescription.entity(forEntityName: "Movie", in: managedContext)!
    
    let movieEntity = NSManagedObject(entity: entity, insertInto: managedContext)
    
    movieEntity.setValue(movie.name, forKey: "name")
    movieEntity.setValue(movie.rating, forKey: "rating")
    movieEntity.setValue(movie.releaseDate, forKey: "releaseDate")
    movieEntity.setValue(movie.youTubeLink, forKey: "youTubeLink")
    movieEntity.setValue(movie.desc, forKey: "desc")
    movieEntity.setValue(movie.imageData, forKey: "imageData")
    
    do {
      try managedContext.save()
      print("Saved")
    } catch let error as NSError {
      print("Error - \(error)")
    }
  }
  
  func getMovies() -> [Movie]? {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
    let managedContext = appDelegate.persistentContainer.viewContext
    
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Movie")
    
    do {
      let objects = try managedContext.fetch(fetchRequest)
      var movies = [Movie]()
      for object in objects {
        guard
          let name = object.value(forKey: "name") as? String,
          let rating = object.value(forKey: "rating") as? Double,
          let releaseDate = object.value(forKey: "releaseDate") as? Date,
          let link = object.value(forKey: "youTubeLink") as? URL,
          let desc = object.value(forKey: "desc") as? String,
          let imageData = object.value(forKey: "imageData") as? Data
        else { return nil }
        let movie = Movie(
          name: name,
          rating: rating,
          releaseDate: releaseDate,
          link: link,
          desc: desc,
          image: UIImage(data: imageData) ?? UIImage.add
        )
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
    
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Movie")
    fetchRequest.predicate = NSPredicate(format: "%K =%@", "name", name)
    
    do {
      let objects = try managedContext.fetch(fetchRequest)
      for object in objects {
        managedContext.delete(object)
        print("Deleted")
      }
      try managedContext.save()
    } catch let error as NSError {
      print("Error - \(error)")
    }
  }
}
