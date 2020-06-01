//
//  Request.swift
//  CoCoMed
//
//  Created by Nikita Srivastava on 18/05/20.
//  Copyright © 2020 LifeSparkTech. All rights reserved.
//

import Foundation

public class Request : RequestProtocol
{
    public var endPoint: EndPoints
    public var method: HTTPMethod
    public var urlParams: ParametersDict?
    public var body: RequestBody?
    public var headers: HeadersDict?
    public var cachePolicy: URLRequest.CachePolicy?
    public var timeout: TimeInterval?
    
    public init(method : HTTPMethod = .get, endpoint : EndPoints, urlParams : ParametersDict? = nil, body : RequestBody? = nil, headers : HeadersDict? = nil)
    {
        self.method = method
        self.endPoint = endpoint
        self.urlParams = urlParams
        self.body = body
        self.headers = headers
        self.cachePolicy = .reloadIgnoringLocalCacheData
        self.timeout = 30.0
    }
}

