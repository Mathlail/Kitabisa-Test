//
//  MovieDetailWireframe.swift
//  Kitabisa Test
//
//  Created by FDN-Fajri Ramadhan on 13/03/21.
//

import UIKit

final class MovieDetailWireframe: BaseWireframe {

    // MARK: - Private properties -

    // MARK: - Module setup -

    init(movie: MovieModel) {
        let moduleViewController = MovieDetailViewController()
        super.init(viewController: moduleViewController)
        
        let interactor = MovieDetailInteractor()
        let presenter = MovieDetailPresenter(wireframe: self, view: moduleViewController, interactor: interactor, movie: movie)
        moduleViewController.presenter = presenter
    }

}

// MARK: - Extensions -

extension MovieDetailWireframe: MovieDetailWireframeInterface {

    func navigate(to option: MovieDetailNavigationOption) {
    }
}
