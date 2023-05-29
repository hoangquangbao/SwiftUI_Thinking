//
//  NewMockDataService_Test.swift
//  SwiftUI_Thinking_Tests
//
//  Created by Quang Bao on 17/05/2023.
//

import XCTest
@testable import SwiftUI_Thinking
import Combine

final class NewMockDataService_Test: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        cancellables.removeAll()
    }
    
    func test_NewMockDataService_init_doesSetValuesCorrectly() {
        // Give
        let items: [String]? = nil
        let items2: [String]? = []
        let items3: [String]? = [UUID().uuidString, UUID().uuidString]
        
        // When
        let dataService = NewMockDataService(items: items)
        let dataService2 = NewMockDataService(items: items2)
        let dataService3 = NewMockDataService(items: items3)

        // Then
        /// If assigned a nil value then item will be get default value
        XCTAssertNotNil(dataService.items)
        
        XCTAssertTrue(dataService2.items.isEmpty)
        XCTAssertEqual(dataService3.items.count, items3?.count)
    }
    
    func test_NewMockDataService_downloadItemWithEscaping_doesSetValuesCorrectly() {
        // Give
        let dataService = NewMockDataService(items: nil)
        
        // When
        var items: [String] = []
        let expectation = XCTestExpectation()
        
        dataService.downloadItemWithEscaping { returnedItems in
            items = returnedItems
            expectation.fulfill()
        }
        
        // Then
        wait(for: [expectation], timeout: 3)
        XCTAssertEqual(items.count, dataService.items.count)
    }
    
    func test_NewMockDataService_downloadItemWithCombine_doesSetValuesCorrectly() {
        // Give
        let dataService = NewMockDataService(items: nil)
        
        // When
        var items: [String] = []
        let expectation = XCTestExpectation()
        
        dataService.downloadItemWithEscaping { returnedItems in
            items = returnedItems
            expectation.fulfill()
        }
        dataService.downloadItemWithCombine()
            .sink { returnCompletion in
                switch returnCompletion {
                case .finished:
                    expectation.fulfill()
                case .failure:
                    XCTFail()
                }
            } receiveValue: { returnItems in
                items = returnItems
            }
            .store(in: &cancellables)

        // Then
        wait(for: [expectation], timeout: 3)
        XCTAssertEqual(items.count, dataService.items.count)
    }
    
    func test_NewMockDataService_downloadItemWithCombine_doesFail() {
        // Give
        let dataService = NewMockDataService(items: [])
        
        // When
        var items: [String] = []
        let expectation = XCTestExpectation(description: "Does throw an error")
        let expectation2 = XCTestExpectation(description: "Does throw URLError.badServerResponse")
        
        /// This func for testing downloadwithESCAPING
        dataService.downloadItemWithEscaping { returnedItems in
            items = returnedItems
            expectation.fulfill()
        }
        
        /// This func for testing for downloaditemwithCOMBINE
        dataService.downloadItemWithCombine()
            .sink { returnCompletion in
                switch returnCompletion {
                case .finished:
                    XCTFail()
                case .failure(let error):
                    expectation.fulfill()
                    XCTAssertEqual(dataService.items.count, items.count)
                    
                    let urlError = error as? URLError
                    XCTAssertEqual(urlError, URLError(.badServerResponse))
                    
                    if urlError == URLError(.badServerResponse) {
                        expectation2.fulfill()
                    }
                }
            } receiveValue: { returnItems in
                items = returnItems
            }
            .store(in: &cancellables)

        // Then
        wait(for: [expectation, expectation2], timeout: 3)
        XCTAssertEqual(items.count, dataService.items.count)
    }
}
