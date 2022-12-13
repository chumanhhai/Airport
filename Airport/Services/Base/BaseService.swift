//
//  BaseService.swift
//  Airport
//
//  Created by dohg on 07/12/2022.
//

import RxAlamofire
import Alamofire
import RxSwift

class BaseService {
    
    func requestGet(withUrl url: String,
                    header: HTTPHeaders = HttpRouter.defaultHeader,
                    body: Parameters? = nil) -> Single<BackendResponse> {
        return request(withUrl: url, method: .get, header: header, body: body)
    }
    
}

extension BaseService {
    
    private func request(withUrl url: String,
                         method: HTTPMethod,
                         header: HTTPHeaders = HttpRouter.defaultHeader,
                         body: Parameters? = nil) -> Single<BackendResponse> {
        print(url)
        return RxAlamofire.requestData(method, url, parameters: body, headers: header)
            .map { (response, body) -> BackendResponse in
                return BackendResponse(withResponseCode: response.statusCode, responseBody: body)
            }
            .asSingle()
    }
    
}
