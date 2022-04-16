//
//  MovieMO+CoreDataProperties.swift
//  MovieSaver
//
//  Created by Yushkevich Ilya on 10.04.22.
//
//

import Foundation
import CoreData


extension MovieMO {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieMO> {
    return NSFetchRequest<MovieMO>(entityName: "MovieMO")
  }
  
  @NSManaged public var desc: String?
  @NSManaged public var imageData: Data?
  @NSManaged public var name: String?
  @NSManaged public var rating: Double
  @NSManaged public var releaseDate: Date?
  @NSManaged public var youTubeLink: URL?
  
}

extension MovieMO : Identifiable {
  
}
