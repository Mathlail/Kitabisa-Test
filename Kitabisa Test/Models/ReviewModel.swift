//
//  ReviewModel.swift
//  Kitabisa Test
//
//  Created by FDN-Fajri Ramadhan on 13/03/21.
//

import Foundation

struct ReviewModel: Codable, Equatable {
    private(set) var id: String?
    private(set) var author: String?
    private(set) var content: String?
    
    static func ==(lhs: ReviewModel, rhs: ReviewModel) -> Bool {
        return lhs.id == rhs.id
    }
}
