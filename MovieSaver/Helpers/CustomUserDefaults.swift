//
//  CustomUserDefaultsSingleton.swift
//  MovieSaver
//
//  Created by Yushkevich Ilya on 22.01.22.
//

import Foundation

final class CustomUserDefaults {
    private init() {}

    static func set<T: Codable>(object: T, key: String) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(object), forKey: key)
    }

    static func get<T: Codable>(key: String) -> T? {
        if let data = UserDefaults.standard.value(forKey: key) as? Data {
            if let obj = try? PropertyListDecoder().decode(T.self, from: data) {
                return obj
            }
        }
        return nil
    }
}
