//
//  DogImage.swift
//  API Project Part 2
//
//  Created by Cesar Fernandez on 7/5/24.
//

import Foundation

struct DogImage: Codable {
    var url: URL? {
        URL(string: message)
    }
    private let message: String
}
