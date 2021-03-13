//
//  MovieDetailInteractor.swift
//  Kitabisa Test
//
//  Created by FDN-Fajri Ramadhan on 13/03/21.
//

import Foundation

final class MovieDetailInteractor {
}

// MARK: - Extensions -

extension MovieDetailInteractor: MovieDetailInteractorInterface {
    func requestReviewList(id: Int, completion: @escaping (Result<[ReviewModel], Error>) -> Void) {
        guard let url = URLHelper.shared.getMovieURL(type: .reviews(id: id)) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let _ = self else { return }
            if let error = error {
                completion(.failure(error))
            }
            
            do {
                guard let data = data else { return }
                let model = try JSONDecoder().decode(BaseResponseModel<ReviewModel>.self, from: data)
                completion(.success(model.results ?? []))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func getLocalData() -> [MovieModel]? {
        return UserDefaultsHelper.shared.loadUserDefaults(expectedObject: [MovieModel].self, key: .favorites)
    }
}
