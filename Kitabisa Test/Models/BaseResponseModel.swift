//
//  BaseResponseModel.swift
//  Kitabisa Test
//
//  Created by FDN-Fajri Ramadhan on 13/03/21.
//

import Foundation

struct BaseResponseModel <T: Codable>: Codable {
    let page: Int?
    let results: [T]?
    let totalPages: Int?
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
    }
}
