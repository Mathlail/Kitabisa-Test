//
//  MovieListInteractorTest.swift
//  Kitabisa TestTests
//
//  Created by FDN-Fajri Ramadhan on 14/03/21.
//

import XCTest
@testable import Kitabisa_Test

class MovieListInteractorTest: XCTestCase {

    let interactor = MovieListInteractor()
    
    func requestMovies(urlType: URLHelper.URLType, fileName: String) {
        let stub = UnitTestHelper.shared.createStub(type: urlType, filename: fileName, inBundleForClass: type(of: self))
        let successExpectation = XCTestExpectation(description: "SuccessExpectation")
        var errorResponse: Error?
        interactor.requestMovieList(type: urlType) { (result) in
            switch result {
            case .success(let response):
                let mockResponse = UnitTestHelper.shared.loadJson(fileName: fileName, type: MovieModel.self)
                XCTAssertEqual(response, mockResponse?.results)
                successExpectation.fulfill()
            case .failure(let error):
                errorResponse = error
            }
        }
        wait(for: [successExpectation], timeout: 5)
        XCTAssertNil(errorResponse)
        UnitTestHelper.shared.removeStub(stub!)
    }
    
    func testRequestPopularMovies() {
        requestMovies(urlType: .popular, fileName: "GetPopularMoviesSuccess.json")
    }
    
    func testRequestUpcomingMovies() {
        requestMovies(urlType: .upcoming, fileName: "GetUpcomingMoviesSuccess.json")
    }
    
    func testRequestTopRatedMovies() {
        requestMovies(urlType: .topRated, fileName: "GetTopRatedMoviesSuccess.json")
    }
    
    func testRequestNowPlayingMovies() {
        requestMovies(urlType: .nowPlaying, fileName: "GetNowPlayingMoviesSuccess.json")
    }

}
