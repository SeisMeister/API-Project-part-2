//
//  ContentView.swift
//  API Project Part 2
//
//  Created by Cesar Fernandez on 7/5/24.
//

import SwiftUI
import UIKit

struct Dog: Identifiable {
    let id = UUID()
    var name: String
    let url: URL
    var image: UIImage?
}

struct ContentView: View {
    @State var dogs = [Dog]()
    @State var newDogName = ""
    @State var randomDogImage: UIImage? = nil
    @State var randomDogURL: URL? = nil
    @State var isLoading = true
    
    var body: some View {
        NavigationView {
            VStack {
                if let randomDogImage = randomDogImage {
                    Image(uiImage: randomDogImage)
                        .resizable()
                        .padding()
                        .overlay(
                            ProgressView()
                                .controlSize(.large)
                                .opacity(isLoading ? 1 : 0)
                                .tint(.white)
                        )
                }
                
                TextField("Name?", text: $newDogName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Button(action: saveDog) {
                        Text("Save And Generate New")
                            .foregroundStyle(.blue)
                    }
                .padding()
                .disabled(newDogName.isEmpty || randomDogImage == nil)
                
                List($dogs) { $dog in
                    // Call an array of dog images
                    NavigationLink(destination: DogDetailView(dog: $dog)) {
                        HStack {
                            if let image = dog.image {
                                Image(uiImage: image)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            } else {
                                ProgressView()
                                    .frame(width: 50, height: 50)
                            }
                            Text(dog.name)
                                .font(.headline)
                        }
                    }
                }
                .navigationTitle("Dogs List")
                .listStyle(.plain)
            }
        }
        .task {
            await loadNewDogImage()
        }
    }
    
    func saveDog() {
        Task {
            if let currentDogImage = randomDogImage, let randomDogURL {
                let newDog = Dog(name: newDogName, url: randomDogURL, image: currentDogImage)
                dogs.insert(newDog, at: 0)
                newDogName = ""
                await loadNewDogImage()
            }
        }
    }
    
    func loadNewDogImage() async {
        isLoading = true
        if let newDogImage = await DogImageAPI.randomDog(),
           let uiImage = await DogImageAPI.image(from: newDogImage) {
            randomDogImage = uiImage
            randomDogURL = newDogImage.url
        }
        isLoading = false
    }
}

#Preview {
    ContentView()
}
