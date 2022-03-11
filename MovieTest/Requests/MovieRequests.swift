//
//  MovieRequests.swift
//  MovieTest
//
//  Created by Eugen Lukashuk on 10.03.2022.
//

import Foundation

class MovieRequests: MovieApi {
    func fetchPopularMovies(page: Int, state: HomeEntity.HomeState, completion: @escaping (HomeEntity.Response.ListMovies?, Error?) -> ()) {
        
        let query = [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "sort_by", value: "popularity.desc")
        ]
        
        let path: String
        
        switch state {
        case .popular:
            path = "/movie/popular"
        case .featuredNow:
            path = "/movie/now_playing"
        case .myFavorites:
            path = "/account/\(key)/favorite/movies"
        }
        
        guard let url = createApiUrl(with: path, queryItems: query) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> () in
            do {
                if error != nil {
                    completion(nil, error)
                    return
                }
                
                guard let data = data else { return }
                
                let decoder = JSONDecoder()
                let result = try decoder.decode(HomeEntity.Response.ListMovies.self, from: data)
                completion(result, nil)
            } catch {
                completion(nil, MovieServiceError.CannotFetchMovie())
            }
        }).resume()
    }
    
    func fetchMovie(id: Int, completion: @escaping (HomeEntity.Response.Movie?, Error?) -> ()) {
        let path = "/movie/\(id)"
        
        guard let url = createApiUrl(with: path, queryItems: []) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> () in
            do {
                if error != nil {
                    completion(nil, error)
                    return
                }
                
                guard let data = data else {
                    completion(nil, MovieServiceError.CannotFetchMovie())
                    return
                }
                
                let decoder = JSONDecoder()
                let result = try decoder.decode(HomeEntity.Response.Movie.self, from: data)
                completion(result, nil)
            } catch {
                completion(nil, MovieServiceError.CannotFetchMovie())
            }
        }).resume()
    }
    
    func addMovieToFavorite(id: Int, completion: @escaping (Error?) -> ()) {
        let path = "/account/\(key)/favorite"
        
        guard let url = createApiUrl(with: path, queryItems: []) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> () in
            guard let error = error else {
                completion(nil)
                return
            }
            
            completion(error)
        }).resume()
    }
}

enum MovieServiceError: Equatable, Error {
    case CannotFetch(String = "")
    case CannotFetchMovie(String = "")
}
