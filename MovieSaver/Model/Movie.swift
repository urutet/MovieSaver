//
//  Movie.swift
//  MovieSaver
//
//  Created by Yushkevich Ilya on 8.01.22.
//

import Foundation
import UIKit

struct Movie: Codable {
    var name: String
    var rating: Double
    var releaseDate: Date
    var youTubeLink: URL
    var desc: String
    var image: UIImage {
        get {
            UIImage(data: imageData) ?? UIImage()
        }
        set {
            imageData = newValue.jpegData(compressionQuality: 0.8) ?? Data()
        }
    }

    private var imageData: Data = .init() // Only for UserDefaults

    init(name: String, rating: Double, releaseDate: Date, link: URL, desc: String, image: UIImage) {
        self.name = name
        self.rating = rating
        self.releaseDate = releaseDate
        self.youTubeLink = link
        self.desc = desc
    }

    // Custom Codable realization. Coding keys + decoder&encoder
    private enum CodingKeys: String, CodingKey {
        case name, rating, releaseDate, youTubeLink, desc, imageData
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.rating = try container.decode(Double.self, forKey: .rating)
        self.releaseDate = try container.decode(Date.self, forKey: .releaseDate)
        self.youTubeLink = try container.decode(URL.self, forKey: .youTubeLink)
        self.desc = try container.decode(String.self, forKey: .desc)
        self.imageData = try container.decode(Data.self, forKey: .imageData)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(rating, forKey: .rating)
        try container.encode(releaseDate, forKey: .releaseDate)
        try container.encode(youTubeLink, forKey: .youTubeLink)
        try container.encode(desc, forKey: .desc)
        try container.encode(imageData, forKey: .imageData)
    }

}

extension Movie {
    func getOutOfTenRating(ofSize: CGFloat) -> NSMutableAttributedString {
        return NSMutableAttributedString()
            .bold(String(rating), ofSize: ofSize)
            .normal("/10", ofSize: ofSize)
    }
}
