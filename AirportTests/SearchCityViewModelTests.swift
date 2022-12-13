//
//  SearchCityViewModelTests.swift
//  AirportTests
//
//  Created by dohg on 13/12/2022.
//

import XCTest
@testable import Airport
import RxSwift
import RxTest

class SearchCityViewModelTests: XCTestCase {

    var disposeBag: DisposeBag!
    var scheduler: ConcurrentDispatchQueueScheduler!
    var testScheduler: TestScheduler!
    
    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
        scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
        testScheduler = TestScheduler(initialClock: 0)
    }
    
    func test_FetchAirports() {
        /// Our objective is to test `SearchCityViewModel` class, therefore, it will not make sense if we must wait for `AirportService`
        /// to connect to server and wait for json back (what if it takes so long? result is not what we expect? or even server dies?).
        /// Hence, we MUST create `AirportServiceMock` to inject into `SearchCityViewModel`
        ///
        let airportServiceMock = AirportServiceMock()
        let searchCityViewModel = SearchCityViewModel(airportService: airportServiceMock)
        let airport = testScheduler.createObserver(Airport.self)

        searchCityViewModel.fetchAirports()
//        searchCityViewModel.airports.subscribe(onNext: {
//            guard let airport = $0.first else {
//                XCTFail()
//                return
//            }
//            XCTAssertEqual(airport.name, "Noi bai")
//            XCTAssertEqual(airport.lat, 0)
//            XCTAssertEqual(airport.long, 0)
//            XCTAssertEqual(airport.city, "Hanoi")
//            XCTAssertEqual(airport.state, "Hanoi")
//            XCTAssertEqual(airport.country, "Vietnam")
//            XCTAssertEqual(airport.runwayLength, 4000)
//        })
//        .disposed(by: disposeBag)
        searchCityViewModel.airports
            .map { $0.first!}.bind(to: airport)
            .disposed(by: disposeBag)
        XCTAssertRecordedElements(airport.events, [Airport(name: "Noi bai",
                                                           lat: 0,
                                                           long: 0,
                                                           city: "Hanoi",
                                                           state: "Hanoi",
                                                           country: "Vietnam",
                                                           runwayLength: 4000)])
    }

}
