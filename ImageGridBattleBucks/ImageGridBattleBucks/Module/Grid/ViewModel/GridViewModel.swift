//
//  GridViewModel.swift
//  ImageGridBattleBucks
//
//  Created by STUPA-TECH on 27/09/24.
//

import Foundation
import Combine
import SwiftUI

class GalleryViewModel: ObservableObject {
    @Published var photos: [Photo] = []
      private var cache = NSCache<NSString, UIImage>()
      private var cancellables = Set<AnyCancellable>()
      
      // Fetch photos from API using HTTPUtilities
      func fetchPhotos() {
          HTTPUtilities.shared.fetchData(from: "https://jsonplaceholder.typicode.com/photos", decodeTo: [Photo].self)
              .sink(receiveCompletion: { completion in
                  switch completion {
                  case .failure(let error):
                      print("Error: \(error)")
                  case .finished:
                      break
                  }
              }, receiveValue: { [weak self] photos in
                  self?.photos = photos
              })
              .store(in: &cancellables)
      }
      
      // Load and Cache Image
      func loadImage(url: String, completion: @escaping (UIImage?) -> Void) {
          if let cachedImage = cache.object(forKey: url as NSString) {
              completion(cachedImage)
              return
          }
          
          guard let imageURL = URL(string: url) else {
              completion(nil)
              return
          }
          
          URLSession.shared.dataTask(with: imageURL) { [weak self] data, _, _ in
              guard let data = data, let image = UIImage(data: data) else {
                  completion(nil)
                  return
              }
              
              self?.cache.setObject(image, forKey: url as NSString)
              DispatchQueue.main.async {
                  completion(image)
              }
          }.resume()
      }
}
