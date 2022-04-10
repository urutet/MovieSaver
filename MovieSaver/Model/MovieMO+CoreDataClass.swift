//
//  MovieMO+CoreDataClass.swift
//  MovieSaver
//
//  Created by Yushkevich Ilya on 10.04.22.
//
//

import Foundation
import CoreData

@objc(MovieMO)
public class MovieMO: NSManagedObject {
  convenience init(movie: Movie, entity: NSEntityDescription, context: NSManagedObjectContext) {
    self.init(entity: entity, insertInto: context)
    self.name = movie.name
    self.rating = movie.rating
    self.releaseDate = movie.releaseDate
    self.youTubeLink = movie.youTubeLink
    self.desc = movie.desc
    self.imageData = movie.imageData
  }
}
