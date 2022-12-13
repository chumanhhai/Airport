//
//  HttpRouter.swift
//  Airport
//
//  Created by dohg on 07/12/2022.
//

import Alamofire

class HttpRouter {
    
    enum Endpoint: String {
        
        case airports = "airports.json"
        
    }
    
    static let baseUrl = "https://gist.githubusercontent.com/tdreyno/4278655/raw/7b0762c09b519f40397e4c3e100b097d861f5588"
    static let defaultHeader: HTTPHeaders = [:]
    
    static func customHeader(withExtraInfo newInfo: HTTPHeaders) -> HTTPHeaders {
        var customHeader = defaultHeader
        for field in newInfo {
            customHeader.add(field)
        }
        return customHeader
    }
    
    static func getFullUrl(withEndpoint endpoint: Endpoint, parameters: [String: String]? = nil, baseUrl: String = baseUrl) -> String {
        let strUrl = "\(baseUrl)/\(endpoint.rawValue)"
        if let parameters = parameters {
            var queryItems: [URLQueryItem] = []
            for (key, value) in parameters {
                queryItems.append(URLQueryItem(name: key, value: value))
            }
            var urlComponent = URLComponents(string: strUrl)!
            urlComponent.queryItems = queryItems
            return urlComponent.string!
        }
        return strUrl
    }
    
}
