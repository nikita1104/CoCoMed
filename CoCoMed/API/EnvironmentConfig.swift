//
//  EnvironmentConfig.swift
//  CoCoMed
//
//  Created by Nikita Srivastava on 18/05/20.
//  Copyright © 2020 LifeSparkTech. All rights reserved.
//

import Foundation


public final class EnvironmentConfig
{
    private(set) var name : String
    private(set) var baseUrl : String
    private(set) var pathApi : String
    
    public init(name : String? = nil,base urlString : String,path pathApi : String? = nil)
    {
        self.name = name!
        self.baseUrl = urlString
        self.pathApi = pathApi!
    }
    
    public convenience init?()
    {
        let appCfg = Bundle.main.object(forInfoDictionaryKey: ServerConfig.endpoint.rawValue) as! [String : Any]
        
        guard let base = appCfg[ServerConfig.base.rawValue] else
        {
            return nil
        }
        self.init(name: appCfg[ServerConfig.name.rawValue] as? String, base: base as! String, path: appCfg[ServerConfig.pathApi.rawValue] as? String)
    }
}

public enum ServerConfig : String
{
    case endpoint = "EndPoint"
    case base = "base"
    case pathApi = "path"
    case defaultPathApi = "defaultpath"
    case webbase = "webbase"
    case name = "name"
}

public enum ServerEnvironmentName : String
{
    case debug = "Debug"
    case production = "Production"
    
}
