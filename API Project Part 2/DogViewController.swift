//
//  DogViewController.swift
//  API Project Part 2
//
//  Created by Cesar Fernandez on 7/5/24.
//

import Foundation

class DogViewController {
    
    func updateImageView() {
        Task {
            // load new dog image
            let dogImage = await DogImageAPI.randomDog()
            // assign dog image to imageView
            let image = await DogImageAPI.image(from: dogImage)
//            imageView.image = image
        }
    }
}
