//
//  DataTransferProtocol.swift
//  MovieSaver
//
//  Created by Yushkevich Ilya on 9.01.22.
//

import Foundation

protocol TextTransferDelegate: AnyObject {
    func transferText(_ text: String, controller: ControllerType)
}

protocol MovieTransferDelegate: AnyObject {
    func transferMovie(_ obj: Movie)
}
