//
//  GridUIComponent.swift
//  ImageGridBattleBucks
//
//  Created by STUPA-TECH on 27/09/24.
//

import SwiftUI

struct GridUIComponent: View {
    let url: String
       @State private var image: UIImage?
       
       var body: some View {
           if let image = image {
               Image(uiImage: image)
                   .resizable()
           } else {
               Color.gray 
                   .onAppear {
                       fetchImage()
                   }
           }
       }
       
       private func fetchImage() {
           GalleryViewModel().loadImage(url: url) { loadedImage in
               self.image = loadedImage
           }
       }
}


