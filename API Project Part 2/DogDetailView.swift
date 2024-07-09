//
//  ListView.swift
//  API Project Part 2
//
//  Created by Cesar Fernandez on 7/5/24.
//

import SwiftUI

struct DogDetailView: View {
    @Binding var dog: Dog
    
    var body: some View {
        VStack {
            if let image = dog.image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 200, height: 200)
            } else {
                ProgressView()
                    .frame(width: 200, height: 200)
            }
            TextField("Enter dog name", text: $dog.name)
                .font(.largeTitle)
                .padding()
            Spacer()
        }
        .navigationTitle(dog.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
