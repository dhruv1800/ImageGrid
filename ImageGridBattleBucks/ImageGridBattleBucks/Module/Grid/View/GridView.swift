//
//  ContentView.swift
//  ImageGridBattleBucks
//
//  Created by STUPA-TECH on 27/09/24.
//

import SwiftUI
import SwiftData

struct GridView: View {
    @StateObject private var viewModel = GalleryViewModel()
        
        let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
        
        var body: some View {
            NavigationView {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(viewModel.photos) { photo in
                            VStack {
                                GridUIComponent(url: photo.thumbnailUrl)
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100, height: 100)
                                    .clipped()
                                Text(photo.title)
                                    .font(.caption)
                                    .lineLimit(2)
                            }
                        }
                    }
                    .padding()
                }
                .navigationTitle("Image Gallery")
                .onAppear {
                    viewModel.fetchPhotos()
                }
            }
        }
}

#Preview {
    GridView()
        
}
