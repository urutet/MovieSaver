//
//  AddMovieViewModel.swift
//  MovieSaver
//
//  Created by Yushkevich Ilya on 5.04.22.
//

import Foundation
import UIKit

enum AddMovieViewModelAction {
  case nameChanged(String)
  case ratingChanged(Double)
  case releaseDateChanged(Date)
  case linkChanged(URL)
  case imageChanged(UIImage)
  case descriptionChanged(String)
}

final class AddMovieViewModel: ViewModel<AddMovieViewModelAction> {
  var image: UIImage? = nil {
    didSet {
      post(.imageChanged(image!), to: nil)
    }
  }
  var name: String? = nil {
    didSet {
      post(.nameChanged(name!), to: nil)
    }
  }
  var rating: Double? = nil {
    didSet {
      post(.ratingChanged(rating!), to: nil)
    }
  }
  var releaseDate: Date? = nil {
    didSet {
      post(.releaseDateChanged(releaseDate!), to: nil)
    }
  }
  var link: URL? = nil {
    didSet {
      post(.linkChanged(link!), to: nil)
    }
  }
  var desc: String? = nil {
    didSet {
      post(.descriptionChanged(desc!), to: nil)
    }
  }
  
  var eventHandler: ((Movie) -> Void)?
  
  func save() {
    guard let name = self.name,
          let rating = self.rating,
          let releaseDate = self.releaseDate,
          let link = self.link,
          let desc = self.desc,
          let image = self.image
    else { return }
    var movie = Movie(
      name: name,
      rating: rating,
      releaseDate: releaseDate,
      link: link,
      desc: desc,
      image: image
    )
    movie.image = image
    
    CoreDataService.instance.saveMovie(movie)
    
    eventHandler?(movie)
  }
}
