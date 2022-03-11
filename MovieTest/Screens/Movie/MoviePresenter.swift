//
//  MoviePresenter.swift
//  MovieTest
//
//  Created by Eugen Lukashuk on 10.03.2022.
//

import Foundation

protocol MoviePresenterProtocol {
    func getData()
}

class MoviePresenter: MoviePresenterProtocol {
    private unowned let view: MovieViewControllerProtocol
    private let movieApi = MovieRequests()
    private let id: Int?
    
    required init(view: MovieViewControllerProtocol, id: Int?) {
        self.view = view
        self.id = id
    }
    
    func getData() {
        guard let id = id else { return }
        
        view.setupBlockScreen(flag: true)
        
        movieApi.fetchMovie(id: id) { [weak self] data, errorResponse in
            guard let self = self else { return }
            
            if let errorResponse = errorResponse {
                self.view.showError(error: errorResponse)
            }
            
            if let data = data {
                self.setupViewEntity(data: data)
            }
            
            self.view.setupBlockScreen(flag: false)
        }
    }
    
    
    private func setupViewEntity(data: HomeEntity.Response.Movie) {
        let entity = HomeEntity.View.MovieEntity(
            id: data.id ?? 0,
            name: data.title ?? "",
            posterURL: MovieApi.getImageUrl(path: data.posterPath ?? ""),
            description: data.overview ?? "",
            releaseDate: data.releaseDate ?? "",
            popularity: data.popularity ?? 0)
        
        view.display(data: entity)
    }
}
