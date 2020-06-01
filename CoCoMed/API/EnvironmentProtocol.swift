//
//  EnvironmentProtocol.swift
//  CoCoMed
//
//  Created by Nikita Srivastava on 18/05/20.
//  Copyright © 2020 LifeSparkTech. All rights reserved.
//

import Foundation


public protocol EnvironmentProtocol
{
    var configuration : EnvironmentConfig { get }
    init(_ configuration : EnvironmentConfig)
}
