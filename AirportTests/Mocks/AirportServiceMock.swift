//
//  AirportServiceMock.swift
//  AirportTests
//
//  Created by dohg on 13/12/2022.
//

import Foundation
@testable import Airport
import RxSwift

class AirportServiceMock: AirportServiceProtocol {
    
    func getAirports() -> Single<[Airport]?> {
        let airport = Airport(name: "Noi bai",
                              lat: 0,
                              long: 0,
                              city: "Hanoi",
                              state: "Hanoi",
                              country: "Vietnam",
                              runwayLength: 4000)
        return Single<[Airport]?>.create { single -> Disposable in
            single(.success([airport]))
            return Disposables.create()
        }
    }
    
}
