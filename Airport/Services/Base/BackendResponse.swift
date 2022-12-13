//
//  BackendResponse.swift
//  Airport
//
//  Created by dohg on 07/12/2022.
//

import SwiftyJSON

struct BackendResponse {
    
    let isSuccess: Bool
    let data: JSON
    
    init(withResponseCode responseCode: Int, responseBody: Data) {
        switch responseCode {
        case 200 ..< 300:
            isSuccess = true
            data = JSON(responseBody)
        default:
            isSuccess = false
            data = JSON(Data())
        }
    }
    
}
