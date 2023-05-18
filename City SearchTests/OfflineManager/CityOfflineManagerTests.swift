//
//  CityOfflineManagerTests.swift
//  City SearchTests
//
//  Created by Kaung Htet Win on 18/5/2566 BE.
//

import XCTest
import RxSwift
import RxTest

@testable import City_Search

class CityOfflineManagerTests: XCTestCase {
    // MARK: Subject under test
    var sut: CityOfflineManager!
    
    var scheduler: TestScheduler!
    private let bag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        scheduler = TestScheduler(initialClock: 0, resolution: 0.01)
        sut = CityOfflineManager(fileName: "mockCities")
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testShouldGetCitiesData() {
        // Given
        let fileName = "mockCities"
        // Then
        sut = CityOfflineManager(fileName: fileName)
        // When
        let cities = sut.city
        XCTAssertEqual(cities.count, 4, "cities count should be 3")
    }
    
    func testShouldGetEmptyCitiesLoadWrongFiles() {
        // Given
        let fileName = "mockCitie"
        // When
        sut = CityOfflineManager(fileName: fileName)
        // Then
        let cities = sut.city
        XCTAssertEqual(cities.count, 0, "cities count should be 0")
    }
    
    func testShouldGetEmptyCities() {
        // Given
        let fileName = "mockEmptyCities"
        // When
        sut = CityOfflineManager(fileName: fileName)
        // Then
        let cities = sut.city
        XCTAssertEqual(cities.count, 0, "cities count should be 0")
    }
    
    func testShouldGetSearchResult() {
        // Given
        let fileName = "mockCities"
        let observer = scheduler.createObserver([City].self)
        let coord = Coord(lon: 44.549999, lat: 100.5018)
        let mockObject = City(
            country: "TH",
            name: "Bangkok",
            id: 707861,
            coord: coord)
        sut = CityOfflineManager(fileName: fileName)
        // When
        sut.search(query: "Bangkok")
            .subscribe(observer)
            .disposed(by: bag)
        // Then
        let exceptEvents: [Recorded<Event<[City]>>] = [
            .next(0, [mockObject])
        ]
        XCTAssertEqual(observer.events, exceptEvents, "search result should be bangkok object")
    }
    
    func testShouldGetEmptySearchResult() {
        // Given
        let fileName = "mockCities"
        let observer = scheduler.createObserver([City].self)
        sut = CityOfflineManager(fileName: fileName)
        // When
        sut.search(query: "Mandalay")
            .subscribe(observer)
            .disposed(by: bag)
        // Then
        let exceptEvents: [Recorded<Event<[City]>>] = [
            .next(0, [])
        ]
        XCTAssertEqual(observer.events, exceptEvents, "search result should be empty object")
    }
    
    func testBinarySearch() {
        // Given
        let fileName = "mockCities"
        // When
        sut = CityOfflineManager(fileName: fileName)
        // Then
        let cities = sut.binarySearch(text: "Ya")
        XCTAssertEqual(cities.count, 2, "cities count should be 2")
        XCTAssertEqual(cities.first?.name, "Yangon", "first city name should be Yangon")
        XCTAssertEqual(cities.last?.name, "Yankin", "second city name should be Yankin")
    }
}
