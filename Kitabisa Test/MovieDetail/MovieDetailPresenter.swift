//
//  MovieDetailPresenter.swift
//  Kitabisa Test
//
//  Created by FDN-Fajri Ramadhan on 13/03/21.
//

import UIKit

final class MovieDetailPresenter {

    // MARK: - Private properties -

    private unowned let _view: MovieDetailViewInterface
    private let _wireframe: MovieDetailWireframeInterface
    private let _interactor: MovieDetailInteractorInterface
    var _movie: MovieModel

    // MARK: - Lifecycle -

    init(wireframe: MovieDetailWireframeInterface, view: MovieDetailViewInterface, interactor: MovieDetailInteractorInterface, movie: MovieModel) {
        _wireframe = wireframe
        _view = view
        _interactor = interactor
        _movie = movie
    }
    
    func requestReviews() {
        guard let id = _movie.id else { return }
        _wireframe.showHUDLoading(true)
        _interactor.requestReviewList(id: id) { [weak self] (result) in
            self?._wireframe.showHUDLoading(false)
            switch result {
            case .success(let data):
                self?._view.showReviews(model: data)
            case .failure(let error):
                self?._wireframe.showAlert(withTitle: nil, message: error.localizedDescription, cancelButtonTitle: "OK", confirmButtonTitle: nil, tapHandler: nil)
            }
        }
    }
    
    func checkIsFavoriteMovie() -> Bool {
        guard let currentFavoriteList = _interactor.getLocalData() else { return false }
        if currentFavoriteList.contains(where: {$0.id == _movie.id}) {
            return true
        }
        return false
    }
}

// MARK: - Extensions -

extension MovieDetailPresenter: MovieDetailPresenterInterface {
    func viewDidLoad() {
        requestReviews()
        _view.setupMovieCardView(model: _movie)
        _view.setupFavoriteButton(isSelected: checkIsFavoriteMovie())
    }
    
    func configureToLocalData(isSelected: Bool) {
        if isSelected {
            if var currentFavoriteList = _interactor.getLocalData() {
                currentFavoriteList.insert(_movie, at: 0)
                UserDefaultsHelper.shared.saveToUserDefaults(object: currentFavoriteList, key: .favorites)
            } else {
                UserDefaultsHelper.shared.saveToUserDefaults(object: [_movie], key: .favorites)
            }
        } else {
            if var currentFavoriteList = _interactor.getLocalData(), let id = currentFavoriteList.firstIndex(where: {$0.id == _movie.id}) {
                currentFavoriteList.remove(at: id)
                UserDefaultsHelper.shared.saveToUserDefaults(object: currentFavoriteList, key: .favorites)
            }
        }
        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: UserDefaultsHelper.Key.favorites.rawValue), object: nil)
    }
}
