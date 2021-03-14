//
//  MovieModel.swift
//  Kitabisa Test
//
//  Created by FDN-Fajri Ramadhan on 13/03/21.
//

import Foundation

struct MovieModel: Codable, Equatable {
    private(set) var id: Int?
    private(set) var title: String?
    private(set) var releaseDate: String?
    private(set) var synopsis: String?
    private(set) var image: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title = "original_title"
        case releaseDate = "release_date"
        case synopsis = "overview"
        case image = "poster_path"
    }
    
    static func ==(lhs: MovieModel, rhs: MovieModel) -> Bool {
        return lhs.id == rhs.id
    }
}
