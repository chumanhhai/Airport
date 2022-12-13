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
    
    func test_FetchAirports() {
        /// Our objective is to test `SearchCityViewModel` class, therefore, it will not make sense if we must wait for `AirportService`
        /// to connect to server and wait for json back (what if it takes so long? result is not what we expect? or even server dies?).
        /// Hence, we MUST create `AirportServiceMock` to inject into `SearchCityViewModel`
        ///
        let airportServiceMock = AirportServiceMock()
        let searchCityViewModel = SearchCityViewModel(airportService: airportServiceMock)

        searchCityViewModel.fetchAirports()
        searchCityViewModel.airports.subscribe(onNext: {
            guard let airport = $0.first else {
                XCTFail()
                return
            }
            XCTAssertEqual(airport.name, "Noi bai")
            XCTAssertEqual(airport.lat, 0)
            XCTAssertEqual(airport.long, 0)
            XCTAssertEqual(airport.city, "Hanoi")
            XCTAssertEqual(airport.state, "Hanoi")
            XCTAssertEqual(airport.country, "Vietnam")
            XCTAssertEqual(airport.runwayLength, 4000)
        })
        .disposed(by: disposeBag)
        
        /// NOTE: lí thuyết là như thế, nhưng hiện tại test này chưa chạy được vì RxSwift issue, em sẽ học cách để test được code viết bằng RxSwift.
    }

}
