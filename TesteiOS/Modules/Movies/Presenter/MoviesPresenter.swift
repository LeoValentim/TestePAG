//
//  MoviesPresenter.swift
//  DesafioTembici
//
//  Created by Leo Valentim on 29/04/19.
//  Copyright © 2019 LeoValentim. All rights reserved.
//

// MARK: - Presenter
class MoviesPresenter {
    weak var view: MoviesInput?
    var interactor: MoviesInteractorPresenter?
    var router: MoviesRouterProtocol?
    
    var genres: [GenreViewModel] = []
    var movies: [MovieViewModel] = []
    var filteredMovies: [MovieViewModel] = []
    var isAscendingOrdering: Bool = true
}

// MARK: - Presenter / View
protocol MoviesOutput: class {
    var orderButtonTitle: String {get}
    var moviesCount: Int {get}
    func getMovie(at index: Int) -> MovieViewModel
    func getMovies()
    func setFavoriteMovie(at index: Int)
    
    func filterContentForSearchText(_ text: String)
    func changeOrdering()
    
    func goToDetailsOfMovie(at index: Int)
}
extension MoviesPresenter: MoviesOutput {
    var orderButtonTitle: String {
        return isAscendingOrdering ? "Crescente" : "Decrescente"
    }
    var moviesCount: Int {
        if view?.isFiltering == true {
            return filteredMovies.count
        }
        return movies.count
    }
    func getMovie(at index: Int) -> MovieViewModel {
        if view?.isFiltering == true {
            return filteredMovies[index]
        }
        return movies[index]
    }
    func getMovies() {
        if genres.isEmpty {
            interactor?.fetchGenres { genres in
                self.genres = genres
                self.interactor?.getMovies()
            }
        } else {
            interactor?.getMovies()
        }
    }
    func setFavoriteMovie(at index: Int) {
        let model: MovieViewModel
        if view?.isFiltering == true {
            model = filteredMovies[index]
        } else {
            model = movies[index]
        }
        
        interactor?.setMovie(model, asFavorite: !model.isFavorite)
    }
    
    func filterContentForSearchText(_ text: String) {
        filteredMovies = movies.filter( { (movie: MovieViewModel) -> Bool in
            return movie.title.uppercased().contains(text.uppercased())
        })
        
        view?.didFilter()
    }
    func changeOrdering() {
        if isAscendingOrdering {
            movies.sort { $0.releaseDate < $1.releaseDate }
            filteredMovies.sort { $0.releaseDate < $1.releaseDate }
        } else {
            movies.sort { $0.releaseDate > $1.releaseDate }
            filteredMovies.sort { $0.releaseDate > $1.releaseDate }
        }
        
        isAscendingOrdering = !isAscendingOrdering
        view?.didChangeOrdering()
    }
    
    func goToDetailsOfMovie(at index: Int) {
        let model: MovieViewModel
        if view?.isFiltering == true {
            model = filteredMovies[index]
        } else {
            model = movies[index]
        }
        
        router?.navigateToDetails(of: model)
    }
}

// MARK: - Presenter / Interactor
protocol MoviesPresenterInteractor: class {
    func didRequestMovies(movies: [MovieViewModel])
    func didFavoriteMovie()
    func didFailure(_ error: Error)
}
extension MoviesPresenter: MoviesPresenterInteractor {
    func didRequestMovies(movies: [MovieViewModel]) {
        self.movies = []
        movies.forEach { movie in
            var newMovie = movie
            newMovie.genreIDS?.forEach { genreId in
                if !newMovie.genres.contains(where: { $0.id == genreId }),
                    let genre = genres.first(where: { $0.id == genreId }) {
                    newMovie.genres.append(genre)
                }
            }
            self.movies.append(newMovie)
        }
        
        if isAscendingOrdering {
            self.movies.sort { $0.releaseDate > $1.releaseDate }
        } else {
            self.movies.sort { $0.releaseDate < $1.releaseDate }
        }
        
        view?.didGetMovies()
    }
    
    func didFavoriteMovie() {
        view?.didFavoriteMovie()
    }
    
    func didFailure(_ error: Error) {
        view?.didFailure(error)
    }
}
