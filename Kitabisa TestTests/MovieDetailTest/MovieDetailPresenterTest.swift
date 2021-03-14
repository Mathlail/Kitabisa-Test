//
//  MovieDetailPresenterTest.swift
//  Kitabisa TestTests
//
//  Created by FDN-Fajri Ramadhan on 14/03/21.
//

import XCTest
@testable import Kitabisa_Test

class MovieDetailPresenterTest: XCTestCase {

    class MockWireframe: MovieDetailWireframeInterface {
        func navigate(to option: MovieDetailNavigationOption) {
            
        }
        
        var mockWireframeData: MovieModel?
        
        func showHUDLoading(_ show: Bool) {
            
        }
        
        func showAlert(withTitle title: String?, message: String, cancelButtonTitle: String, confirmButtonTitle: String?, tapHandler: ((UIAlertAction) -> Void)?) {
            
        }
        
        func close() {
            
        }
    }
    
    class MockInteractor: MovieDetailInteractorInterface {
        var mockReviewsResponse: [ReviewModel]?
        
        init() {
            mockReviewsResponse = UnitTestHelper.shared.loadJson(fileName: "GetReviewsSuccess.json", type: ReviewModel.self)?.results
        }
        
        func getLocalData() -> [MovieModel]? {
            return UserDefaultsHelper.shared.loadUserDefaults(expectedObject: [MovieModel].self, key: .favorites)
        }
        
        func requestReviewList(id: Int, completion: @escaping (Result<[ReviewModel], Error>) -> Void) {
            
            completion(.success(mockReviewsResponse ?? []))
        }
    }
    
    class MockView: MovieDetailViewInterface {
        var mockReviewsData: [ReviewModel]?
        var mockMovieData: MovieModel?
        var mockIsSelected: Bool?
        func setupMovieCardView(model: MovieModel) {
            mockMovieData = model
        }
        
        func showReviews(model: [ReviewModel]) {
            mockReviewsData = model
        }
        
        func setupFavoriteButton(isSelected: Bool) {
            mockIsSelected = isSelected
        }
    }
    
    let mockWireframe = MockWireframe()
    let mockInteractor = MockInteractor()
    let mockView = MockView()
    var presenter: MovieDetailPresenter?
    
    override func setUp() {
        guard let mockResponse = UnitTestHelper.shared.loadJson(fileName: "GetPopularMoviesSuccess.json", type: MovieModel.self), let firstItem = mockResponse.results?.first else { return }
        presenter = MovieDetailPresenter(wireframe: mockWireframe, view: mockView, interactor: mockInteractor, movie: firstItem)
        UserDefaults.standard.removeObject(forKey: "favorites")
    }
    
    func testLoadedData() {
        presenter?.viewDidLoad()
        XCTAssertEqual(mockInteractor.mockReviewsResponse, mockView.mockReviewsData)
        XCTAssertEqual(presenter?._movie, mockView.mockMovieData)
        XCTAssertEqual(mockView.mockIsSelected, false)
    }
    
    func testInsertFavoriteMovieToLocalData() {
        presenter?.configureToLocalData(isSelected: true)
        guard let currentMovieData = presenter?._movie else { return }
        XCTAssertTrue(mockInteractor.getLocalData()?.contains(currentMovieData) ?? false)
    }

}
