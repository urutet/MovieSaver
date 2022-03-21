//
//  DataTransferProtocol.swift
//  MovieSaver
//
//  Created by Yushkevich Ilya on 9.01.22.
//

import Foundation

protocol TextTransferDelegate: AnyObject {
    func transferText(_ text: String, controller: ChangeInfoViewControllerInputType)
}

protocol MovieTransferDelegate: AnyObject {
    func transferMovie(_ obj: Movie)
}

protocol DateTransferDelegate: AnyObject {
    func transferDate(_ date: Date)
}

protocol URLTransferDelegate: AnyObject {
    func transferURL(_ url: URL)
}
