//
//  MovieApi.swift
//  MovieTest
//
//  Created by Eugen Lukashuk on 10.03.2022.
//

import Foundation

class MovieApi {
    let key = "2c46288716a18fb7aadcc2a801f3fc6b"
    private let language = "en-US"
    private let url = "https://api.themoviedb.org/3"
    private static let imageBaseUrl = "https://image.tmdb.org/t/p/original"
    
    func createApiUrl(with path: String, queryItems: [URLQueryItem]) -> URL? {
        var query = [
            URLQueryItem(name: "api_key", value: key),
            URLQueryItem(name: "language", value: language)
        ]
        query.append(contentsOf: queryItems)
        var urlComponents = URLComponents(string: "\(url)\(path)")
        urlComponents?.queryItems = query
        return urlComponents?.url
    }
    
    static func getImageUrl(path: String) -> String {
        return imageBaseUrl + path
    }
}
