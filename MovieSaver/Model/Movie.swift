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
}

extension Movie {
    func getOutOfTenRating(ofSize: CGFloat) -> NSMutableAttributedString {
        return NSMutableAttributedString()
            .bold(String(rating), ofSize: ofSize)
            .normal("/10", ofSize: ofSize)
    }
}
