//
//  MovieDetailsRouter.swift
//  DesafioTembici
//
//  Created by Leo Valentim on 30/04/19.
//  Copyright © 2019 LeoValentim. All rights reserved.
//

import UIKit

class MovieDetailsRouter {
    
    private weak var view: MovieDetailsViewController?
    
    static var storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle(for: MovieDetailsRouter.self))
    
    static func createModule(with model: MovieViewModel) -> MovieDetailsViewController? {
        guard let view = storyBoard.instantiateViewController(withIdentifier: String(describing: MovieDetailsViewController.self)) as? MovieDetailsViewController else { return nil }
        
        let router = MovieDetailsRouter()
        let interector = MovieDetailInterector()
        let presenter = MovieDetailsPresenter()
        
        router.view = view
        interector.presenter = presenter
        presenter.router = router
        presenter.interector = interector
        presenter.view = view
        view.presenter = presenter
        view.model = model
        
        return view
    }
}
