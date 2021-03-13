//
//  MovieListInteractor.swift
//  Kitabisa Test
//
//  Created by FDN-Fajri Ramadhan on 13/03/21.
//

import Foundation

final class MovieListInteractor {
}

// MARK: - Extensions -

extension MovieListInteractor: MovieListInteractorInterface {
    func requestMovieList(type: URLHelper.URLType, completion: @escaping (Result<[MovieModel], Error>) -> Void) {
        guard let url = URLHelper.shared.getMovieURL(type: type) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let _ = self else { return }
            if let error = error {
                completion(.failure(error))
            }
            
            do {
                guard let data = data else { return }
                let model = try JSONDecoder().decode(BaseResponseModel<MovieModel>.self, from: data)
                completion(.success(model.results ?? []))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
}
