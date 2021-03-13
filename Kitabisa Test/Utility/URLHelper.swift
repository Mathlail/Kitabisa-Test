//
//  URLHelper.swift
//  Kitabisa Test
//
//  Created by FDN-Fajri Ramadhan on 13/03/21.
//

import Foundation

class URLHelper {
    static let shared = URLHelper()
    
    func baseURL() -> String {
        return "https://api.themoviedb.org"
    }
    
    enum URLType {
        case popular
        case topRated
        case nowPlaying
        case upcoming
        case image(id: Int)
        case reviews(id: Int)
        
    }
    
    func constructURL(path: String) -> URL? {
        var urlComponents = URLComponents(string: baseURL())
        urlComponents?.path = "/3/movie" + path
        urlComponents?.queryItems = [URLQueryItem(name: "api_key", value: "e808657774386196b3e50f6928fce567")]
        return urlComponents?.url
    }
    
    func getMovieURL(type: URLType) -> URL? {
        var path = ""
        switch type {
        case .popular:
            path = "/popular"
        case .topRated:
            path = "/top_rated"
        case .nowPlaying:
            path = "/now_playing"
        case .upcoming:
            path = "/upcoming"
        case .image(let id):
            path = "/\(id)/images"
        case .reviews(let id):
            path = "/\(id)/reviews"
        }
        return constructURL(path: path)
    }
}
