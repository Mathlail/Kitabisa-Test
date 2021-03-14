//
//  FavoriteMovieListInteractorTest.swift
//  Kitabisa TestTests
//
//  Created by FDN-Fajri Ramadhan on 14/03/21.
//

import XCTest
@testable import Kitabisa_Test

class FavoriteMovieListInteractorTest: XCTestCase {

    let interactor = FavoriteMovieListInteractor()
    
    func testGetMovieListData() {
        XCTAssertEqual(interactor.getLocalData(), UserDefaultsHelper.shared.loadUserDefaults(expectedObject: [MovieModel].self, key: .favorites))
    }

}
