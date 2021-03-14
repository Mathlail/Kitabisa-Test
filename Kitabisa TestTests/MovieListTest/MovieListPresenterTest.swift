//
//  MovieListPresenterTest.swift
//  Kitabisa TestTests
//
//  Created by FDN-Fajri Ramadhan on 14/03/21.
//

import XCTest
@testable import Kitabisa_Test

class MovieListPresenterTest: XCTestCase {

    class MockWireframe: MovieListWireframeInterface {
        var isFavoritePageOpen: Bool?
        var mockWireframeData: MovieModel?
        
        func navigate(to option: MovieListNavigationOption) {
            switch option {
            case .detail(let movie):
                mockWireframeData = movie
            case .favorites:
                isFavoritePageOpen = true
            }
        }
        
        func showHUDLoading(_ show: Bool) {
            
        }
        
        func showAlert(withTitle title: String?, message: String, cancelButtonTitle: String, confirmButtonTitle: String?, tapHandler: ((UIAlertAction) -> Void)?) {
            
        }
        
        func close() {
            
        }
    }
    
    class MockInteractor: MovieListInteractorInterface {
        let mockResponse = UnitTestHelper.shared.loadJson(fileName: "GetPopularMoviesSuccess.json", type: MovieModel.self)?.results
        
        func requestMovieList(type: URLHelper.URLType, completion: @escaping (Result<[MovieModel], Error>) -> Void) {
            completion(.success(mockResponse ?? []))
        }
        
        
    }
    
    class MockView: MovieListViewInterface {
        var mockMovieData: [MovieModel]?
        func showData<T>(_ data: [T]) where T : Decodable, T : Encodable {
            mockMovieData = data as? [MovieModel]
        }
    }
    
    let mockWireframe = MockWireframe()
    let mockInteractor = MockInteractor()
    let mockView = MockView()
    var presenter: MovieListPresenter?
    
    override func setUp() {
        presenter = MovieListPresenter(wireframe: mockWireframe, view: mockView, interactor: mockInteractor)
    }
    
    func testSelectionCell() {
        presenter?.viewDidLoad()
        presenter?.didSelectItemCollectionView(index: 0)
        XCTAssertEqual(presenter?._data.first, mockWireframe.mockWireframeData)
    }
    
    func testFavoriteNavigation() {
        presenter?.openFavorites()
        XCTAssertTrue(mockWireframe.isFavoritePageOpen ?? false)
    }
    
    func testRequestMovieList() {
        presenter?.movieTypeDidChange(tag: 0)
        XCTAssertEqual(mockInteractor.mockResponse, mockView.mockMovieData)
    }

}
