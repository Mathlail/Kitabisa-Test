//
//  MovieListWireframe.swift
//  Kitabisa Test
//
//  Created by FDN-Fajri Ramadhan on 13/03/21.
//

import UIKit

final class MovieListWireframe: BaseWireframe {

    // MARK: - Private properties -

    // MARK: - Module setup -

    init() {
        let moduleViewController = MovieListViewController()
        super.init(viewController: moduleViewController)
        
        let interactor = MovieListInteractor()
        let presenter = MovieListPresenter(wireframe: self, view: moduleViewController, interactor: interactor)
        moduleViewController.presenter = presenter
    }

}

// MARK: - Extensions -

extension MovieListWireframe: MovieListWireframeInterface {

    func navigate(to option: MovieListNavigationOption) {
        switch option {
        case .detail(let movie):
            navigationController?.pushWireframe(MovieDetailWireframe(movie: movie))
        case .favorites:
            navigationController?.pushWireframe(FavoriteMovieListWireframe())
        }
    }
}
