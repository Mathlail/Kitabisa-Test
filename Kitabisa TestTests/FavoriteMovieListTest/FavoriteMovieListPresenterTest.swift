//
//  FavoriteMovieListPresenterTest.swift
//  Kitabisa TestTests
//
//  Created by FDN-Fajri Ramadhan on 14/03/21.
//

import XCTest
@testable import Kitabisa_Test

class FavoriteMovieListPresenterTest: XCTestCase {

    class MockWireframe: FavoriteMovieListWireframeInterface {
        var mockWireframeData: MovieModel?
        func navigate(to option: FavoriteMovieListNavigationOption) {
            switch option {
            case .detail(let movie):
                mockWireframeData = movie
            }
        }
        
        func showHUDLoading(_ show: Bool) {
            
        }
        
        func showAlert(withTitle title: String?, message: String, cancelButtonTitle: String, confirmButtonTitle: String?, tapHandler: ((UIAlertAction) -> Void)?) {
            
        }
        
        func close() {
            
        }
    }
    
    class MockInteractor: FavoriteMovieListInteractorInterface {
        func getLocalData() -> [MovieModel]? {
            return UnitTestHelper.shared.loadJson(fileName: "GetPopularMoviesSuccess.json", type: MovieModel.self)?.results
        }
    }
    
    class MockView: FavoriteMovieListViewInterface {
        var mockViewData: [MovieModel]?
        func showData(model: [MovieModel]) {
            mockViewData = model
        }
    }
    
    let mockWireframe = MockWireframe()
    let mockInteractor = MockInteractor()
    let mockView = MockView()
    var presenter: FavoriteMovieListPresenter?
    
    override func setUp() {
        presenter = FavoriteMovieListPresenter(wireframe: mockWireframe, view: mockView, interactor: mockInteractor)
    }
    
    func testShowData() {
        presenter?.viewDidLoad()
        XCTAssertEqual(mockInteractor.getLocalData(), mockView.mockViewData)
    }
    
    func testSelectionCell() {
        presenter?.viewDidLoad()
        presenter?.didSelectItemCollectionView(index: 0)
        XCTAssertEqual(presenter?._data.first, mockWireframe.mockWireframeData)
    }

}
