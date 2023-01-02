//
//  Movie.swift
//  MovieSaver
//
//  Created by Yushkevich Ilya on 8.01.22.
//

import UIKit
import CoreData

struct Movie {
  var name: String
  var rating: Double
  var releaseDate: Date
  var youTubeLink: URL
  var desc: String
  var image: UIImage {
    get {
      UIImage(data: imageData) ?? UIImage()
    }
  }
  
  var imageData: Data = .init()
  
  init(name: String, rating: Double, releaseDate: Date, link: URL, desc: String, image: UIImage) {
    self.name = name
    self.rating = rating
    self.releaseDate = releaseDate
    self.youTubeLink = link
    self.desc = desc
    self.imageData = image.jpegData(compressionQuality: 1) ?? Data()
  }
}

extension Movie: Equatable {
  func getOutOfTenRating(ofSize: CGFloat) -> NSMutableAttributedString {
    NSMutableAttributedString()
      .bold(String(format: "%.1f", rating), ofSize: ofSize)
      .normal("/10", ofSize: ofSize)
  }
  
  static func == (lhs: Movie, rhs: Movie) -> Bool {
    return
    lhs.name == rhs.name &&
    lhs.rating == rhs.rating &&
    lhs.releaseDate == rhs.releaseDate &&
    lhs.youTubeLink == rhs.youTubeLink &&
    lhs.desc == rhs.desc
  }
}
