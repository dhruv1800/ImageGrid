//
//  ImageDetailView.swift
//  ImageGridBattleBucks
//
//  Created by STUPA-TECH on 27/09/24.
//

import SwiftUI

struct ImageDetailView: View {
    @Binding var selectedPhotoIndex: Int
    var photos: [Photo]

    var body: some View {
        TabView(selection: $selectedPhotoIndex) {
            ForEach(photos.indices, id: \.self) { index in
                VStack {
                    AsyncImageView(url: photos[index].url)
                        .frame(maxWidth: .infinity, maxHeight: 300)
                        .aspectRatio(contentMode: .fit)
                        .padding()

                    Text(photos[index].title)
                        .font(.headline)
                        .padding()

                    
                    Text("Photo ID: \(photos[index].id)")
                        .font(.subheadline)
                        .padding(.bottom, 5)
                    
                    Text("Album ID: \(photos[index].albumId)")
                        .font(.subheadline)
                        .padding(.bottom, 10)
                    
                    Spacer()
                }
                .tag(index) // For managing tab view index
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        .navigationTitle("Image Details")
    }
}



