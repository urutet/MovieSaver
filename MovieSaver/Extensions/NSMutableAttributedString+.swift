//
//  NSMutableAttributedString+.swift
//  MovieSaver
//
//  Created by Yushkevich Ilya on 26.01.22.
//

import UIKit

extension NSMutableAttributedString {
    var fontSize: CGFloat { return 14 }
    var boldFont: UIFont { return UIFont(name: "Manrope-Bold",
                                         size: fontSize)
        ?? UIFont.boldSystemFont(ofSize: fontSize) }
    var normalFont: UIFont { return UIFont(name: "Manrope-Regular",
                                           size: fontSize)
        ?? UIFont.systemFont(ofSize: fontSize)}

    func bold(_ value: String, ofSize: CGFloat) -> NSMutableAttributedString {

        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Manrope-Bold", size: ofSize) ?? UIFont.boldSystemFont(ofSize: ofSize)
        ]

        self.append(NSAttributedString(string: value, attributes: attributes))
        return self
    }

    func normal(_ value: String, ofSize: CGFloat) -> NSMutableAttributedString {

        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Manrope-Regular", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
        ]

        self.append(NSAttributedString(string: value, attributes: attributes))
        return self
    }
}
