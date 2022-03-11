//
//  HomePresenter.swift
//  MovieTest
//
//  Created by Eugen Lukashuk on 10.03.2022.
//

import Foundation

protocol HomePresenterProtocol {
    var state: HomeEntity.HomeState { get set }
    var moviesList: HomeEntity.Response.ListMovies { get set }
    func getData(nextPage: Bool)
}

class HomePresenter: HomePresenterProtocol {
    private unowned let view: HomeViewControllerProtocol
    
    let movieApi = MovieRequests()
    var state: HomeEntity.HomeState = .popular
    var isLoading = false
    var moviesList = HomeEntity.Response.ListMovies()
    
    required init(view: HomeViewControllerProtocol) {
        self.view = view
    }
    
    func getData(nextPage: Bool) {
        if isLoading {
            return
        }
        
        isLoading = true
        
        guard var page = self.moviesList.page else { return }
        
        if nextPage {
            guard let totalPages = self.moviesList.totalPages else { return }
            if page >= totalPages {
                isLoading = false
                return
            }
            page += 1
        }
        
        view.setupBlockScreen(flag: true)
        
        movieApi.fetchPopularMovies(page: page, state: state) { [weak self] data, errorResponse in
            guard let self = self else { return }
            
            self.isLoading = false
            
            if let errorResponse = errorResponse {
                self.view.showError(error: errorResponse)
            }
            
            if let data = data {
                self.moviesList.page = data.page
                self.moviesList.totalPages = data.totalPages
                
                if nextPage {
                    self.moviesList.movies?.append(contentsOf: data.movies ?? [])
                } else {
                    self.moviesList.movies = data.movies
                }
                
                self.setupViewEntity()
            }
            
            self.view.setupBlockScreen(flag: false)
        }
    }
    
    private func setupViewEntity() {
        guard let movies = moviesList.movies else {
            view.display(data: [])
            return
        }
        
        let viewEntity = movies.map ({ HomeEntity.View.MovieEntity(
            id: $0.id ?? 0,
            name: $0.title ?? "",
            posterURL: MovieApi.getImageUrl(path: $0.posterPath ?? ""),
            description: $0.overview ?? "",
            releaseDate: $0.releaseDate ?? "",
            popularity: $0.popularity ?? 0) })
        
        view.display(data: viewEntity)
    }
}
