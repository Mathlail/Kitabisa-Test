//
//  FavoriteMovieListInteractor.swift
//  Kitabisa Test
//
//  Created by FDN-Fajri Ramadhan on 13/03/21.
//

import Foundation

final class FavoriteMovieListInteractor {
}

// MARK: - Extensions -

extension FavoriteMovieListInteractor: FavoriteMovieListInteractorInterface {
    func getLocalData() -> [MovieModel]? {
        return UserDefaultsHelper.shared.loadUserDefaults(expectedObject: [MovieModel].self, key: .favorites)
    }
}
