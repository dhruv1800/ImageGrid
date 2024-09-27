//
//  ContentView.swift
//  ImageGridBattleBucks
//
//  Created by STUPA-TECH on 27/09/24.
//

import SwiftUI
import SwiftData

struct GridView: View {
    @ObservedObject var viewModel: GalleryViewModel
       @State private var selectedPhotoIndex: Int = 0
       @State private var isShowingDetailView = false
       
       var body: some View {
           NavigationView {
               ScrollView {
                   LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 10) {
                       ForEach(viewModel.photos.indices, id: \.self) { index in
                           let photo = viewModel.photos[index]
                           VStack {
                               AsyncImageView(url: photo.thumbnailUrl)
                                   .frame(width: 100, height: 100)
                                   .clipShape(RoundedRectangle(cornerRadius: 10))
                                   .onTapGesture {
                                       selectedPhotoIndex = index
                                       isShowingDetailView = true
                                   }
                               
                               Text(photo.title)
                                   .font(.caption)
                                   .lineLimit(1)
                                   .padding(.top, 5)
                           }
                       }
                   }
                   .padding()
               }
               .navigationTitle("Image Gallery")
               .onAppear {
                   viewModel.fetchPhotos()
               }
               .background(
                   NavigationLink(destination: ImageDetailView(selectedPhotoIndex: $selectedPhotoIndex, photos: viewModel.photos),
                                  isActive: $isShowingDetailView) {
                       EmptyView()
                   }
               )
           }
       }
}

#Preview {
    GridView(viewModel: GalleryViewModel())
        
}
