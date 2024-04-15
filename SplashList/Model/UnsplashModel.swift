//
//  UnsplashModel.swift
//  SplashList
//
//  Created by Tushar on 13/04/24.
//

import Foundation

struct UnsplashPhoto: Codable {
    let id: String
    let urls: URLS
}

struct URLS: Codable {
    let small: URL
}

class UnsplashService {
    func fetchPhotos(page: Int, perPage: Int = 30, completion: @escaping (Result<[UnsplashPhoto], Error>) -> Void) {
        let urlString = "\(APIConstants.fullSplashUrl)?client_id=\(Configuration.shared.unsplashAccessKey)&page=\(page)&per_page=\(perPage)"
        guard let url = URL(string: urlString) else {
            return completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
        }
        WebService.shared.getRequest(url: url, completion: completion)
    }
}
