//
//  UIDatePicker+.swift
//  MovieSaver
//
//  Created by Yushkevich Ilya on 9.01.22.
//

import Foundation
import UIKit

extension UIDatePicker {
    func getDateAsString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: self.date)
    }
}
