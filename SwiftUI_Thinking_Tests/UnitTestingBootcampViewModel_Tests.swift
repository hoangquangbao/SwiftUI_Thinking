//
//  UnitTestingBootcampViewModel_Tests.swift
//  SwiftUI_Thinking_Tests
//
//  Created by Quang Bao on 15/05/2023.
//

import XCTest
@testable import SwiftUI_Thinking

// Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehavior
// Naming Structure: test_[struct or class]_[variable or function]_[expected result]

// Testing Structure: Given, When, Them

final class UnitTestingBootcampViewModel_Tests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func test_UnitTestingBootcampViewModel_isPremium_shouldBeTrue() {
        // Given
        let userIsPremium: Bool = true
        
        // when
        let vm = UnitTestingBootcampViewModel(isPremium: userIsPremium)
        
        // Then
        XCTAssertTrue(vm.isPremium)
    }
    
    // MARK: - Test Variable
    
    func test_UnitTestingBootcampViewModel_isPremium_shouldBeFalse() {
        // Given
        let userIsPremium: Bool = false
        
        // when
        let vm = UnitTestingBootcampViewModel(isPremium: userIsPremium)
        
        // Then
        XCTAssertFalse(vm.isPremium)
    }
    
    // This test func to replace for 2 funcs above
    func test_UnitTestingBootcampViewModel_isPremium_shouldBeInjectedValue() {
        // Given
        let userIsPremium: Bool = Bool.random()
        
        // when
        let vm = UnitTestingBootcampViewModel(isPremium: userIsPremium)
        
        // Then
        XCTAssertEqual(userIsPremium, vm.isPremium)
    }
    
    // Bool.random just run one time so if you want to run bunch of times you can use loop through
    func test_UnitTestingBootcampViewModel_isPremium_shouldBeInjectedValue_stress() {
        for _ in 0..<10 {
            // Given
            let userIsPremium: Bool = Bool.random()
            
            // when
            let vm = UnitTestingBootcampViewModel(isPremium: userIsPremium)
            
            // Then
            XCTAssertEqual(userIsPremium, vm.isPremium)
        }
    }
    
    //MARK: - Test Array
    // Naming Structure: test_[struct or class]_[variable or function]_[expected result]
    
    func test_UnitTestingBootcampViewModel_dataArray_shouldBeEmpty() {
        // Given
        
        // when
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())
        
        // Then
        XCTAssertTrue(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, 0)
    }
    
    func test_UnitTestingBootcampViewModel_dataArray_shouldNotAddBlankItem() {
        // Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())
        let newItem: String = ""
        
        // when
        //If add a blank value to an array then this array became has value (blank value) rather than nil array.
        //Nếu thêm 1 giá trị trống vào mảng thì mảng này trở thành có giá trị (đó là blank value) thay vì nil như ban đầu.
        vm.addItem(item: newItem)
        
        // Then
        XCTAssertTrue(vm.dataArray.isEmpty)
        XCTAssertFalse(!vm.dataArray.isEmpty)
        
        XCTAssertEqual(vm.dataArray.count, 0)
        XCTAssertNotEqual(vm.dataArray.count, 1)
        
        XCTAssertLessThan(vm.dataArray.count, 1)
    }
    
    func test_UnitTestingBootcampViewModel_dataArray_shouldAddItem() {
        // Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())
        let newItem: String = "Hello"
        
        // when
        vm.addItem(item: newItem)
        
        // Then
        XCTAssertTrue(!vm.dataArray.isEmpty)
        XCTAssertFalse(vm.dataArray.isEmpty)
        
        XCTAssertEqual(vm.dataArray.count, 1)
        XCTAssertNotEqual(vm.dataArray.count, 0)
        
        XCTAssertGreaterThan(vm.dataArray.count, 0)
    }
    
    func test_UnitTestingBootcampViewModel_dataArray_shouldAddItem_stress() {
        // Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())
        
        // When
        let loopCount: Int = Int.random(in: 1..<100)
        for _ in 0..<loopCount {
            vm.addItem(item: UUID().uuidString)
        }
        
        // Then
        XCTAssertTrue(!vm.dataArray.isEmpty)
        XCTAssertFalse(vm.dataArray.isEmpty)
        
        XCTAssertEqual(vm.dataArray.count, loopCount)
        XCTAssertNotEqual(vm.dataArray.count, 0)
        
        XCTAssertGreaterThan(vm.dataArray.count, 0)
    }
    
    // MARK: - Test Selected Item
    func test_UnitTestingBootcampViewModel_selectedItem_shouldBeNilWhenSelectingInvalidItem() {
        // Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())
        
        // When
        
        // Valid case
        let newItem: String = UUID().uuidString
        vm.addItem(item: newItem)
        vm.selectedItem(item: newItem)
        
        // Invalid case
        vm.selectedItem(item: UUID().uuidString)
        
        // Then
        XCTAssertNil(vm.selectedItem)
    }
    
//    func test_UnitTestingBootcampViewModel_selectedItem_shouldBeSelected() {
//        // Given
//        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())
//
//        // When
//        let newItem: String = UUID().uuidString
//        vm.addItem(item: newItem)
//        vm.selectedItem(item: newItem)
//
//        // Then
//        XCTAssertNotNil(vm.selectedItem)
//        XCTAssertEqual(vm.selectedItem, newItem)
//    }
    
    // Combine random for Int, String, element in an Array
    func test_UnitTestingBootcampViewModel_selectedItem_shouldBeSelected_stress() {
        // Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())

        // When
        let loopCount: Int = Int.random(in: 1..<100)
        var tempArray: [String] = []
        
        for _ in 0..<loopCount {
            let newItem: String = UUID().uuidString
            vm.addItem(item: newItem)
            tempArray.append(newItem)
        }
        
        let randomItem = tempArray.randomElement() ?? ""
        XCTAssertFalse(randomItem.isEmpty)
        vm.selectedItem(item: randomItem)

        // Then
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertEqual(vm.selectedItem, randomItem)
    }
    
    func test_UnitTestingBootcampViewModel_saveItem_shouldThrowError_noData() {
        // Give
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())
        
        // When
        let loopCount: Int = Int.random(in: 1..<100)
        for _ in 0..<loopCount {
            vm.addItem(item: UUID().uuidString)
        }
        
        // Then
        XCTAssertThrowsError(try vm.saveItem(item: ""))
        XCTAssertThrowsError(try vm.saveItem(item: ""), "Should throw no data error") { error in
            let returnedError = error as? UnitTestingBootcampViewModel.DataError
            XCTAssertEqual(returnedError, UnitTestingBootcampViewModel.DataError.noData)
        }
    }
    
    func test_UnitTestingBootcampViewModel_saveItem_shouldThrowError_itemNotFound() {
        // Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())

        // When
        let loopCount: Int = Int.random(in: 1..<100)
        for _ in 0..<loopCount {
            vm.addItem(item: UUID().uuidString)
        }
        
        // Then
        XCTAssertThrowsError(try vm.saveItem(item: UUID().uuidString))
        XCTAssertThrowsError(try vm.saveItem(item: UUID().uuidString), "Should throw item not found error") { error in
            let returnedError = error as? UnitTestingBootcampViewModel.DataError
            XCTAssertEqual(returnedError, UnitTestingBootcampViewModel.DataError.itemNotFound)
        }
        
        //Another way
        do {
            try vm.saveItem(item: UUID().uuidString)
        } catch {
            let returnedError = error as? UnitTestingBootcampViewModel.DataError
            XCTAssertEqual(returnedError, UnitTestingBootcampViewModel.DataError.itemNotFound)
        }
    }
    
    func test_UnitTestingBootcampViewModel_saveItem_shouldSaveItem() {
        // Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())

        // When
        let loopCount: Int = Int.random(in: 1..<100)
        var tempArray: [String] = []
        for _ in 0..<loopCount {
            let newItem: String = UUID().uuidString
            vm.addItem(item: newItem)
            tempArray.append(newItem)
        }

        let randomItem = tempArray.randomElement() ?? ""
        XCTAssertFalse(randomItem.isEmpty)

        // Then
        XCTAssertNoThrow(try vm.saveItem(item: randomItem))
        XCTAssertNoThrow(try vm.saveItem(item: randomItem), "Should save item")
        
        //Another way
        do {
            try vm.saveItem(item: randomItem)
        } catch {
            XCTFail()
        }
    }
}
