//
//  DogImageAPI.swift
//  API Project Part 2
//
//  Created by Cesar Fernandez on 7/5/24.
//

import Foundation
import UIKit

struct DogImageAPI {
    
    static func randomDog() async -> DogImage? {
        do {
            // Step 1: Declare URL
            let url = URL(string: "https://dog.ceo/api/breeds/image/random")!
            // Step 2: Get Data back from the URL
            let (data, _) = try await URLSession.shared.data(from: url)
            // Step 3: Convert that data to something you care about
            let dogImage = try JSONDecoder().decode(DogImage.self, from: data)
            return dogImage
        } catch {
            print("failed to get new Dog: \(error)")
            return nil
        }
    }
    
    static func image(from dogImage: DogImage?) async -> UIImage? {
        // Step 1: Declare URL
        guard let url = dogImage?.url else {
            print("dogImage.url did not contain a valid URL: \(String(describing: dogImage))")
            return nil
        }
        // Step 2: Get Data back from the URL
        let (data, _) = try! await URLSession.shared.data(from: url)
        // Step 3: Convert that data to something you care about
        return UIImage(data: data)
    }
    
}
