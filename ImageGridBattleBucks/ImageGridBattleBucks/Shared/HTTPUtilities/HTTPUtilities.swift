//
//  HTTPUtilities.swift
//  ImageGridBattleBucks
//
//  Created by STUPA-TECH on 27/09/24.
//

import Foundation
import Combine

class HTTPUtilities {
    static let shared = HTTPUtilities()
    
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
}
