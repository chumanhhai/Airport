//
//  AirportService.swift
//  Airport
//
//  Created by dohg on 07/12/2022.
//

import RxSwift
import SwiftyJSON

protocol AirportServiceProtocol {
    
    func getAirports() -> Single<[Airport]?>
    
}

class AirportService: BaseService, AirportServiceProtocol {
    
    func getAirports() -> Single<[Airport]?> {
        let url = HttpRouter.getFullUrl(withEndpoint: .airports)
        return requestGet(withUrl: url).map {
            if $0.isSuccess {
                return $0.data.arrayValue.map { Airport(withJson: $0) }
            }
            return nil
        }
    }
    
}
