//
//  MoviesInterector.swift
//  DesafioTembici
//
//  Created by Leo Valentim on 29/04/19.
//  Copyright © 2019 LeoValentim. All rights reserved.
//

// MARK: - Interector
class MoviesInteractor {
    weak var presenter: MoviesPresenterInteractor?
    
    let genreWorker = GenreWorker()
    let movieWorker = MovieWorker()
}

// MARK: - Interector / Presenter
protocol MoviesInteractorPresenter: class {
    func fetchGenres(completion: @escaping ([GenreViewModel]) -> Void)
    func getMovies()
    func setMovie(_ model: MovieViewModel, asFavorite value: Bool)
}
extension MoviesInteractor: MoviesInteractorPresenter {
    func fetchGenres(completion: @escaping ([GenreViewModel]) -> Void) {
        genreWorker.fetchGenres { response in
            switch response {
            case .success(let genres):
                completion(genres)
            case .failure:
                completion([])
            }
        }
    }
    
    func getMovies() {
        movieWorker.fetchMovies { [weak self] response in
            switch response {
            case .success(let movies):
                self?.presenter?.didRequestMovies(movies: movies)
            case .failure(let error):
                self?.presenter?.didFailure(error)
            }
        }
    }
    
    func setMovie(_ model: MovieViewModel, asFavorite value: Bool) {
        do {
            try movieWorker.setMovie(model, asFavorite: value)
            presenter?.didFavoriteMovie()
        } catch {
            presenter?.didFailure(error)
        }
    }
}
