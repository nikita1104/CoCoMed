//
//  GridUtil.swift
//  CoCoMed
//
//  Created by Nikita Srivastava on 01/06/20.
//  Copyright © 2020 LifeSparkTech. All rights reserved.
//



class GridUtil {
    
    static var shared:GridUtil? = GridUtil()
    var count = 0
    var grid = [0.0, 0.0]
    
    private init()
    {
        
    }
    
    
    
    class func destroy()
    {
        shared = GridUtil()
    }
    
}
