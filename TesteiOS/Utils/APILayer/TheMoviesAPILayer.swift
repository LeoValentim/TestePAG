//
//  TheMoviesAPILayer.swift
//  TesteiOS
//
//  Created by resource on 29/09/19.
//  Copyright © 2019 leovalentim. All rights reserved.
//

extension TheMoviesAPILayer {
    enum Controller: String, EndpointController {
        case discover, genre, movie
    }
    
    enum Action: String, EndpointAction {
        case movie, movieList = "movie/list", upcoming
    }
    
    enum Param: String, EndpointParam {
        case api_key, language, sort_by, include_adult, include_video, page
    }
}

/// TheMovie API class that conforms to APILayer protocol
class TheMoviesAPILayer: APILayer {
    
    let baseURLString: String = Constants.API.themoviedb.URL.baseURL.rawValue
    
    private let networkLayer: NetworkLayer
    private var headers: [String : String]
    
    init() {
        self.networkLayer = NetworkLayerAlamofire()
        
        headers = ["Content-Type" : "application/json"]
    }
    
    /// Fetch movies from API
    ///
    /// - Parameter completion: Result API, Error
    func getMovies(completion: @escaping (Result<Movie.Model.UseCases.List.Response, Error>) -> Void) {
        do {
            let url = try EndpointBuilder<Controller, Action, Param>(for: self, withController: .movie)
                .addAction(.upcoming)
                .addParam(.api_key, withValue: Constants.API.themoviedb.key.rawValue)
                .addParam(.language, withValue: "pt-BR")
                .addParam(.page, withValue: "1")
                .build()
            
            networkLayer.get(url, model: Movie.Model.UseCases.List.Response.self, headers: headers, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    /// Fetch Genres from API
    ///
    /// - Parameter completion: Result API, Error
    func getGenres(completion: @escaping (Result<Genre.Model.UseCases.List.Response, Error>) -> Void) {
        do {
            let url = try EndpointBuilder<Controller, Action, Param>(for: self, withController: .genre)
                .addAction(.movieList)
                .addParam(.api_key, withValue: Constants.API.themoviedb.key.rawValue)
                .addParam(.language, withValue: "pt-BR")
                .build()
            
            networkLayer.get(url, model: Genre.Model.UseCases.List.Response.self, headers: headers, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
}
