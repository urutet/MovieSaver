//
//  Movie.swift
//  MovieSaver
//
//  Created by Yushkevich Ilya on 8.01.22.
//

import Foundation
import UIKit

struct Movie {
    var name: String
    var image: UIImage
    var rating: Double
    var releaseDate: Date
    var youTubeLink: URL
    var desc: String
    
    var outOfTenRating: NSMutableAttributedString {
        get {
            let str = NSMutableAttributedString(string: String(rating), attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)])
            str.append(NSAttributedString(string: "/10"))
            return str
        }
    }
}
