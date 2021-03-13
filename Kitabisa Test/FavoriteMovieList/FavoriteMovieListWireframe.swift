//
//  FavoriteMovieListWireframe.swift
//  Kitabisa Test
//
//  Created by FDN-Fajri Ramadhan on 13/03/21.
//

import UIKit

final class FavoriteMovieListWireframe: BaseWireframe {

    // MARK: - Private properties -

    // MARK: - Module setup -

    init() {
        let moduleViewController = FavoriteMovieListViewController()
        super.init(viewController: moduleViewController)
        
        let interactor = FavoriteMovieListInteractor()
        let presenter = FavoriteMovieListPresenter(wireframe: self, view: moduleViewController, interactor: interactor)
        moduleViewController.presenter = presenter
    }

}

// MARK: - Extensions -

extension FavoriteMovieListWireframe: FavoriteMovieListWireframeInterface {

    func navigate(to option: FavoriteMovieListNavigationOption) {
        switch option {
        case .detail(let movie):
            navigationController?.pushWireframe(MovieDetailWireframe(movie: movie))
        }
    }
}
