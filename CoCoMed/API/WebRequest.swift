//
//  WebRequest.swift
//  CoCoMed
//
//  Created by Nikita Srivastava on 18/05/20.
//  Copyright © 2020 LifeSparkTech. All rights reserved.
//

import Foundation


public class WebRequest : WebRequestProtocol
{
    public var endPoint: String
    public var urlParams: ParametersDict?
    public var headers: HeadersDict?
    
    public init(endpoint : String, urlParams : ParametersDict? = nil, headers : HeadersDict? = nil)
    {
        self.endPoint = endpoint
        self.urlParams = urlParams
        self.headers = headers
    }
}

public protocol WebRequestProtocol
{
    var endPoint : String { get set }
    var urlParams : ParametersDict? { get set }
    var headers : HeadersDict? { get set }
}

public enum WebViewCommons : String
{
    case useragent = "ioswebview"
}
