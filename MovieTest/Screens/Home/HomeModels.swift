//
//  HomeModels.swift
//  MovieTest
//
//  Created by Eugen Lukashuk on 10.03.2022.
//

import Foundation

enum HomeEntity {
    struct Request {
        
    }
    
    struct Response {
        struct ListMovies: Codable {
            var page: Int? = 1
            var totalPages: Int? = 1
            var movies: [Movie]? = []
            
            enum CodingKeys: String, CodingKey {
                case page
                case totalPages = "total_pages"
                case movies = "results"
            }
        }
        
        struct Movie: Codable {
            var id: Int?
            var posterPath: String?
            var releaseDate: String?
            var title: String?
            var overview: String?
            var popularity: Double?
            
            enum CodingKeys: String, CodingKey {
                case id
                case posterPath = "poster_path"
                case releaseDate = "release_date"
                case title
                case overview
                case popularity
            }
        }
    }
    
    struct View {
        struct MovieEntity {
            var id: Int
            var name: String
            var posterURL: String
            var description: String
            var releaseDate: String
            var popularity: Double
        }
    }
    
    enum HomeState: Int, CaseIterable {
        case popular
        case featuredNow
        case myFavorites
    }
}
