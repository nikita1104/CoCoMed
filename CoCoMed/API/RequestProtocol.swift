//
//  RequestProtocol.swift
//  CoCoMed
//
//  Created by Nikita Srivastava on 18/05/20.
//  Copyright © 2020 LifeSparkTech. All rights reserved.
//

import Foundation

public protocol RequestProtocol
{
    var endPoint : EndPoints { get set }
    var method : HTTPMethod { get set }
    var urlParams : ParametersDict? { get set }
    var body : RequestBody? { get set }
    var headers : HeadersDict? { get set }
    var cachePolicy : URLRequest.CachePolicy? { get set }
    var timeout : TimeInterval? { get set }
    
}

