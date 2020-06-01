//
//  DispatcherProtocol.swift
//  CoCoMed
//
//  Created by Nikita Srivastava on 18/05/20.
//  Copyright © 2020 LifeSparkTech. All rights reserved.
//

import Foundation

public protocol Dispatcher
{
    init(configuration : EnvironmentConfig)
    func execute(request : Request, completionData : @escaping (_ data : [String : Any], _ statusCode : Int) -> Void)
}

