//
//  HTTPUtilities.swift
//  ImageGridBattleBucks
//
//  Created by STUPA-TECH on 27/09/24.
//

import Foundation
import Combine
import SwiftUI

class HTTPUtilities {
    static let shared = HTTPUtilities()
    public let cache = NSCache<NSString, UIImage>()  // access modifier for test cases
    
    private init() {}
    
    func fetchData<T: Decodable>(from urlString: String, decodeTo type: T.Type) -> AnyPublisher<T, Error> {
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func loadImage(url: String, completion: @escaping (UIImage?) -> Void) {
            // Check cache for image
            if let cachedImage = cache.object(forKey: url as NSString) {
                completion(cachedImage)
                return
            }
            
            // Check if URL is valid
            guard let imageURL = URL(string: url) else {
                completion(nil)
                return
            }
            
            // Fetch image from network if not cached
            URLSession.shared.dataTask(with: imageURL) { [weak self] data, _, error in
                guard let self = self, let data = data, let image = UIImage(data: data), error == nil else {
                    completion(nil)
                    return
                }
                
                // Cache the image
                self.cache.setObject(image, forKey: url as NSString)
                
                // Return image on the main thread
                DispatchQueue.main.async {
                    completion(image)
                }
            }.resume()
        }
}
