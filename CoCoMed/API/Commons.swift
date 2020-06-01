//
//  Commons.swift
//  CoCoMed
//
//  Created by Nikita Srivastava on 18/05/20.
//  Copyright © 2020 LifeSparkTech. All rights reserved.
//

import Foundation

public typealias ParametersDict = [String : Any?]

public typealias HeadersDict = [String: String]

public enum EndPoints : String
{
    case config = "/config"
    
    
}

//Type of HTTP Method
public enum HTTPMethod : String
{
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public enum NetworkError : Error
{
    case invalidURL(_ : String)
    case dataIsNotEncodable(_: Any)
}



public struct RequestBody
{
    let data : Any
    let encoding : Encoding
    public init(data : Any, encoding : Encoding = .json)
    {
        self.data = data
        self.encoding = encoding
    }
    public func encodedData() throws -> Data
    {
        switch self.encoding
        {
            case .rawData :
                return self.data as! Data
            case .rawString(let encoding) :
                guard let str = (self.data as! String).data(using: encoding ) else {
                    throw NetworkError.dataIsNotEncodable(self.data)
                }
                return str
            case .json :
                return try JSONSerialization.data(withJSONObject: self.data, options: [])
        case .urlEncoded(let encoding) :
            let bodyData = self.data as! ParametersDict
            let encodedStr = try urlEncodedString(data : bodyData)
            guard let data = encodedStr.data(using: encoding ) else {
                throw NetworkError.dataIsNotEncodable(encodedStr)
            }
            return data
        }
    }
    private func urlEncodedString(data : [String : Any?]) throws -> String
    {
        let dataItems : [URLQueryItem] = data.compactMap({ (element) -> URLQueryItem in
            return URLQueryItem(name: element.key, value: String(describing: element.value))
        })
        var urlComponents = URLComponents()
        urlComponents.queryItems = dataItems

        guard let encodedStr = urlComponents.query else {
            throw NetworkError.dataIsNotEncodable(urlComponents)
        }
        return encodedStr
    }

}

public enum Encoding
{
    case rawData
    case rawString( _ : String.Encoding)
    case json
    case urlEncoded( _ : String.Encoding)
}


