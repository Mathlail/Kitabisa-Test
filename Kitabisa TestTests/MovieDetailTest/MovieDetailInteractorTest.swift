//
//  MovieDetailInteractorTest.swift
//  Kitabisa TestTests
//
//  Created by FDN-Fajri Ramadhan on 14/03/21.
//

import XCTest
@testable import Kitabisa_Test

class MovieDetailInteractorTest: XCTestCase {

    let interactor = MovieDetailInteractor()
    
    func testGetReviewList() {
        let stub = UnitTestHelper.shared.createStub(type: .reviews(id: 527774), filename: "GetReviewsSuccess.json", inBundleForClass: type(of: self))
        let successExpectation = XCTestExpectation(description: "SuccessExpectation")
        var errorResponse: Error?
        interactor.requestReviewList(id: 527774) { (result) in
            switch result {
            case .success(let response):
                let mockResponse = UnitTestHelper.shared.loadJson(fileName: "GetReviewsSuccess.json", type: ReviewModel.self)
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
    
    func testGetMovieDetailData() {
        XCTAssertEqual(interactor.getLocalData(), UserDefaultsHelper.shared.loadUserDefaults(expectedObject: [MovieModel].self, key: .favorites)) 
    }

}
