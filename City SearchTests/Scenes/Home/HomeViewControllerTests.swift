//
//  HomeViewControllerTests.swift
//  City SearchTests
//
//  Created by Kaung Htet Win on 18/5/2566 BE.
//

import XCTest
import RxTest
import RxCocoa
import RxSwift

@testable import City_Search

class HomeViewControllerTests: XCTestCase {
    
    // MARK: Subject under test
    
    var sut: HomeViewController!
    var window: UIWindow!
    var scheduler: TestScheduler!
    
    private let bag = DisposeBag()
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        scheduler = TestScheduler(initialClock: 0, resolution: 0.01)
        window = UIWindow()
    }
    
    override func tearDown() {
        super.tearDown()
        window = nil
    }
    
    // MARK: Test setup
    
    func setupHomeVC() {
        sut = UIStoryboard.homeViewController()
        sut.viewModel = HomeViewModel(service: CityOfflineManager(fileName: "mockCities"))
        scheduler.createHotObservable([.next(100, "")])
            .bind(to: sut.viewModel.input.searchText)
            .disposed(by: bag)
    }
    
    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    func testShouldConfigureTableViewCellToDisplayCities() {
        // Given
        setupHomeVC()
        loadView()
        let tableView = sut.tblCity
        // When
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = tableView!.cellForRow(at: indexPath) as! CityCell
        // Then
        XCTAssertEqual(cell.cityNameLabel.text, "Bangkok, TH", "A properly configured table view cell should display the city name")
        XCTAssertEqual(cell.locationLabel.text, "100.5018| 44.549999", "A properly configured table view cell should display the location")
    }
}
