//
//  ControllerTypeEnum.swift
//  MovieSaver
//
//  Created by Yushkevich Ilya on 9.01.22.
//

import Foundation

enum ChangeInfoViewControllerInputType {
  case rating
  case name
  case releaseDate
  case link
}

enum ChangeInfoViewControllerOutputType {
  case rating(Double)
  case name(String)
  case releaseDate(Date)
  case link(URL)
}
