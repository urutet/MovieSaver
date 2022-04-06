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
}

final class AddMovieViewModel: ViewModel<AddMovieViewModelAction> {
  var image: UIImage? = nil {
    didSet {
      self.post(.imageChanged(image!), to: nil)
    }
  }
  var name: String? = nil {
    didSet {
      self.post(.nameChanged(name!), to: nil)
    }
  }
  var rating: Double? = nil {
    didSet {
      self.post(.ratingChanged(rating!), to: nil)
    }
  }
  var releaseDate: Date? = nil {
    didSet {
      self.post(.releaseDateChanged(releaseDate!), to: nil)
    }
  }
  var link: URL? = nil {
    didSet {
      self.post(.linkChanged(link!), to: nil)
    }
  }
  
}
