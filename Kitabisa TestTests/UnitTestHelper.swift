//
//  UnitTestHelper.swift
//  Kitabisa TestTests
//
//  Created by FDN-Fajri Ramadhan on 14/03/21.
//

import Foundation
import OHHTTPStubs
@testable import Kitabisa_Test

class UnitTestHelper {
    public static let shared = UnitTestHelper()

    func createStub(type: URLHelper.URLType, filename: String, inBundleForClass: AnyClass, status: Int = 200, headers: [String : String] = ["Content-Type" : "application/json"]) -> HTTPStubsDescriptor? {
        guard let url = URLHelper.shared.getMovieURL(type: type) else { return nil}
        return stub(condition: isAbsoluteURLString(url.absoluteString)) { (request) -> HTTPStubsResponse in
            let stubPath = OHPathForFile(filename, inBundleForClass)
            return fixture(filePath: stubPath!, status: Int32(status), headers: headers)
        }
    }

    func removeStub(_ descriptor: HTTPStubsDescriptor) {
        HTTPStubs.removeStub(descriptor)
    }

    func loadJson<T: Decodable>(fileName: String, type: T.Type) -> BaseResponseModel<T>? {
        guard let stubPath = OHPathForFile(fileName, UnitTestHelper.self) else { return nil }
        let url = URL(fileURLWithPath: stubPath)
        guard let data = try? Data(contentsOf: url), let baseResponse = try? JSONDecoder().decode(BaseResponseModel<T>.self, from: data) else { return nil }
        return baseResponse
    }
}
