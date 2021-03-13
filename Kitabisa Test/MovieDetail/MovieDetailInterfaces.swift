//
//  MovieDetailInterfaces.swift
//  Kitabisa Test
//
//  Created by FDN-Fajri Ramadhan on 13/03/21.
//

import UIKit

enum MovieDetailNavigationOption {
}

protocol MovieDetailWireframeInterface: WireframeInterface {
    func navigate(to option: MovieDetailNavigationOption)
}

protocol MovieDetailViewInterface: ViewInterface {
    func setupMovieCardView(model: MovieModel)
    func showReviews(model: [ReviewModel])
    func setupFavoriteButton(isSelected: Bool)
}

protocol MovieDetailPresenterInterface: PresenterInterface {
    func configureToLocalData(isSelected: Bool)
}

protocol MovieDetailInteractorInterface: InteractorInterface {
    func requestReviewList(id: Int, completion: @escaping (Result<[ReviewModel], Error>) -> Void)
    func getLocalData() -> [MovieModel]?
}
