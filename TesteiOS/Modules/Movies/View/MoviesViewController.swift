//
//  MoviesViewController.swift
//  DesafioTembici
//
//  Created by Leo Valentim on 29/04/19.
//  Copyright © 2019 LeoValentim. All rights reserved.
//

import UIKit

// MARK: - View
class MoviesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    let searchController = UISearchController(searchResultsController: nil)
    var orderByDateButton: UIBarButtonItem?
    
    private var numberOfColumns: Int = 2
    var presenter: MoviesOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupObeservers()
        
        LoadingView.shared.hud.show(in: view)
        presenter?.getMovies()
    }
    
    @objc func didSetFavorite() {
        LoadingView.shared.hud.dismiss()
        presenter?.getMovies()
    }
    
    deinit {
        LocalDataManager.shared.removeObserver(self)
    }
}

// MARK: - Views Configuration Methods
extension MoviesViewController {
    func setupViews() {
        title = "Filmes"
        
        orderByDateButton = UIBarButtonItem(title: presenter?.orderButtonTitle, style: .plain, target: self, action: #selector(orderByDateAction(_:)))
        navigationItem.rightBarButtonItem = orderByDateButton
        
        if #available(iOS 11.0, *) {
            searchController.searchResultsUpdater = self
            searchController.obscuresBackgroundDuringPresentation = false
            searchController.searchBar.placeholder = "Search Movies"
            navigationItem.searchController = searchController
        }
        definesPresentationContext = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: String(describing: MovieCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: MovieCell.self))
        
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Carregando...")
        refreshControl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    func setupObeservers() {
        LocalDataManager.shared.addObserver(self, selector: #selector(didSetFavorite))
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
}

// MARK: - Actions
extension MoviesViewController {
    @objc func orderByDateAction(_ button: UIBarButtonItem) {
        presenter?.changeOrdering()
    }
    
    @objc func refreshAction() {
        LoadingView.shared.hud.show(in: view)
        presenter?.getMovies()
    }
}

// MARK: - UISearchResultsUpdating Delegate
extension MoviesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {return}
        presenter?.filterContentForSearchText(text)
    }
}

// MARK: - CollectionView Delegate & DataSource
extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.moviesCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieCell.self), for: indexPath) as? MovieCell,
            let model = presenter?.getMovie(at: indexPath.row) else { return UICollectionViewCell() }
        cell.setModel(model, favoriteAction: {
            self.presenter?.setFavoriteMovie(at: indexPath.row)
        })
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.width / CGFloat(numberOfColumns)
        let height: CGFloat = width / (168 / 204)
        return CGSize(width: width,
                      height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.goToDetailsOfMovie(at: indexPath.row)
    }
}

// MARK: - View / Presenter
protocol MoviesInput: class {
    var isFiltering: Bool {get}
    func didGetMovies()
    func didFilter()
    func didChangeOrdering()
    func didFavoriteMovie()
    func didFailure(_ error: Error)
}
extension MoviesViewController: MoviesInput {
    var isFiltering: Bool {
        get {
            return searchController.isActive && !searchBarIsEmpty()
        }
    }
    
    func didGetMovies() {
        LoadingView.shared.hud.dismiss()
        collectionView.refreshControl?.endRefreshing()
        collectionView.reloadData()
    }
    
    func didFilter() {
        collectionView.reloadData()
    }
    
    func didChangeOrdering() {
        orderByDateButton?.title = presenter?.orderButtonTitle
        collectionView.reloadData()
    }
    
    func didFavoriteMovie() {
        collectionView.reloadData()
    }
    
    func didFailure(_ error: Error) {
        LoadingView.shared.hud.dismiss()
        collectionView.refreshControl?.endRefreshing()
        print("error: \(error)")
    }
}
