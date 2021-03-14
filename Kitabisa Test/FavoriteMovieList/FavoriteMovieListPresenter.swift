//
//  FavoriteMovieListPresenter.swift
//  Kitabisa Test
//
//  Created by FDN-Fajri Ramadhan on 13/03/21.
//

import UIKit

final class FavoriteMovieListPresenter {

    // MARK: - Private properties -

    private unowned let _view: FavoriteMovieListViewInterface
    private let _wireframe: FavoriteMovieListWireframeInterface
    private let _interactor: FavoriteMovieListInteractorInterface
    var _data = [MovieModel]()

    // MARK: - Lifecycle -
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    init(wireframe: FavoriteMovieListWireframeInterface, view: FavoriteMovieListViewInterface, interactor: FavoriteMovieListInteractorInterface) {
        _wireframe = wireframe
        _view = view
        _interactor = interactor
        NotificationCenter.default.addObserver(self, selector: #selector(didUpdateFavoriteState(_:)), name: NSNotification.Name.init(rawValue: UserDefaultsHelper.Key.favorites.rawValue), object: nil)
    }
    
    @objc func didUpdateFavoriteState(_ sender: Notification) {
        showData()
    }
    
    func showData() {
        guard let data = _interactor.getLocalData() else { return }
        _data = data
        _view.showData(model: data)
    }
    
}

// MARK: - Extensions -

extension FavoriteMovieListPresenter: FavoriteMovieListPresenterInterface {
    func didSelectItemCollectionView(index: Int) {
        _wireframe.navigate(to: .detail(movie: _data[index]))
    }
    
    func viewDidLoad() {
        showData()
    }
}
