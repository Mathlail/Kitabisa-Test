//
//  MovieListPresenter.swift
//  Kitabisa Test
//
//  Created by FDN-Fajri Ramadhan on 13/03/21.
//

import UIKit

final class MovieListPresenter {

    // MARK: - Private properties -

    private unowned let _view: MovieListViewInterface
    private let _wireframe: MovieListWireframeInterface
    private let _interactor: MovieListInteractorInterface
    private var _data = [MovieModel]()
    // MARK: - Lifecycle -

    init(wireframe: MovieListWireframeInterface, view: MovieListViewInterface, interactor: MovieListInteractorInterface) {
        _wireframe = wireframe
        _view = view
        _interactor = interactor
    }
    
    func requestMovies(type: URLHelper.URLType) {
        _interactor.requestMovieList(type: type) { [weak self] (result) in
            switch result {
            case .success(let data):
                self?._data = data
                self?._view.showData(data)
            case .failure(let error):
                self?._wireframe.showAlert(withTitle: nil, message: error.localizedDescription, cancelButtonTitle: "OK", confirmButtonTitle: nil, tapHandler: nil)
            }
        }
    }
}

// MARK: - Extensions -

extension MovieListPresenter: MovieListPresenterInterface {
    func didSelectItemCollectionView(index: Int) {
        _wireframe.navigate(to: .detail(movie: _data[index]))
    }
    
    func viewDidLoad() {
        requestMovies(type: .popular)
    }
    
    func openFavorites() {
        _wireframe.navigate(to: .favorites)
    }
    
    func movieTypeDidChange(tag: Int) {
        switch tag {
        case 0:
            requestMovies(type: .popular)
        case 1:
            requestMovies(type: .upcoming)
        case 2:
            requestMovies(type: .topRated)
        case 3:
            requestMovies(type: .nowPlaying)
        default:
            requestMovies(type: .popular)
        }
    }
}
