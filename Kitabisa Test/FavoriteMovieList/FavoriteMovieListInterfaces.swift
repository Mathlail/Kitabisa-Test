//
//  FavoriteMovieListInterfaces.swift
//  Kitabisa Test
//
//  Created by FDN-Fajri Ramadhan on 13/03/21.
//

import UIKit

enum FavoriteMovieListNavigationOption {
    case detail(movie: MovieModel)
}

protocol FavoriteMovieListWireframeInterface: WireframeInterface {
    func navigate(to option: FavoriteMovieListNavigationOption)
}

protocol FavoriteMovieListViewInterface: ViewInterface {
    func showData(model: [MovieModel])
}

protocol FavoriteMovieListPresenterInterface: PresenterInterface {
    func didSelectItemCollectionView(index: Int)
}

protocol FavoriteMovieListInteractorInterface: InteractorInterface {
    func getLocalData() -> [MovieModel]?
}
