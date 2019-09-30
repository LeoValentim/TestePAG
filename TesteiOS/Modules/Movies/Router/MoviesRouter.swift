//
//  MoviesRouter.swift
//  DesafioTembici
//
//  Created by Leo Valentim on 29/04/19.
//  Copyright © 2019 LeoValentim. All rights reserved.
//

import UIKit

protocol MoviesRouterProtocol: class {
    func navigateToDetails(of model: MovieViewModel)
}

class MoviesRouter: MoviesRouterProtocol {
    
    private weak var view: MoviesViewController?
    
    static var storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle(for: MoviesRouter.self))
    
    static func createModule() -> MoviesViewController? {
        guard let view = storyBoard.instantiateViewController(withIdentifier: String(describing: MoviesViewController.self)) as? MoviesViewController else { return nil }
        
        let presenter = MoviesPresenter()
        let interactor = MoviesInteractor()
        let router = MoviesRouter()
        
        router.view = view
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
        view.presenter = presenter
        
        return view
    }
    
    func navigateToDetails(of model: MovieViewModel) {
        guard let movieDetails = MovieDetailsRouter.createModule(with: model) else {return}
        
        if let navigation = view?.navigationController {
            navigation.pushViewController(movieDetails, animated: true)
        } else {
            view?.present(movieDetails, animated: true, completion: nil)
        }
    }
}
