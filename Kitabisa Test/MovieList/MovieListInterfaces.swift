//
//  MovieListInterfaces.swift
//  Kitabisa Test
//
//  Created by FDN-Fajri Ramadhan on 13/03/21.
//

import UIKit

enum MovieListNavigationOption {
    case detail(movie: MovieModel)
    case favorites
}

protocol MovieListWireframeInterface: WireframeInterface {
    func navigate(to option: MovieListNavigationOption)
}

protocol MovieListViewInterface: ViewInterface {
}

protocol MovieListPresenterInterface: PresenterInterface {
    func didSelectItemCollectionView(index: Int)
    func openFavorites()
    func movieTypeDidChange(tag: Int)
}

protocol MovieListInteractorInterface: InteractorInterface {
    func requestMovieList(type: URLHelper.URLType, completion: @escaping (Result<[MovieModel], Error>) -> Void)
}
