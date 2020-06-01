//
//  NetworkManager.swift
//  CoCoMed
//
//  Created by Nikita Srivastava on 18/05/20.
//  Copyright © 2020 LifeSparkTech. All rights reserved.
//

import UIKit
import Foundation


class NetworkManager: NSObject, Dispatcher {

    private var configuration : EnvironmentConfig
    private var session : URLSession
    
    required public init(configuration: EnvironmentConfig) {
        self.configuration = configuration
        self.session = URLSession.init(configuration: .default)
    }
    
    public func execute(request: Request, completionData: @escaping (_ data : [String : Any], _ statusCode : Int) -> Void) {
        let request = try? prepareUrlRequest(request: request)
        
        
        let task = self.session.dataTask(with: request!, completionHandler: { (data, response, error) in
            if error != nil {
                let err = error! as NSError
                if err.code == -1001 || err.code  == URLError.Code.notConnectedToInternet.rawValue
                {
                    let dict = ["data" : "error"]
                    completionData(dict, err.code)
                }
            } else {
                if let usableData = data{
                    let httpResponse = response as? HTTPURLResponse
                    let statusCode = httpResponse?.statusCode
                    if let jsonStr = try? JSONSerialization.jsonObject(with: usableData, options: .allowFragments)
                    {
                        if let dataStr = jsonStr as? String
                        {
                            let dataDict : [String : Any] = ["data" : dataStr]
                            completionData(dataDict, statusCode!)
                        }
                        if let dataValue = jsonStr as? Bool
                        {
                            let dataDict : [String : Any] = ["data" : dataValue]
                            completionData(dataDict, statusCode!)
                        }
                    }
                    let json = try? JSONSerialization.jsonObject(with: usableData, options: [])
                    if let arr = json as? [Any]
                    {
                        let dataDict : [String : Any] = ["data" : arr]
                        completionData(dataDict, statusCode!)
                    }
                    if let dictionary = json as? [String : Any]
                    {
                        completionData(dictionary, statusCode!)
                    }
                }
            }
        })
        task.resume()
    }
    
    
    public func execute(request: Request,path: String, completionData: @escaping (_ data : [String : Any], _ statusCode : Int) -> Void) {
        let request = try? prepareUrlRequest(request: request,path: path)
        
        
        let task = self.session.dataTask(with: request!, completionHandler: { (data, response, error) in
            if error != nil {
                let err = error! as NSError
                if err.code == -1001 || err.code  == URLError.Code.notConnectedToInternet.rawValue
                {
                    let dict = ["data" : "error"]
                    completionData(dict, err.code)
                }
            } else {
                if let usableData = data{
                    let httpResponse = response as? HTTPURLResponse
                    let statusCode = httpResponse?.statusCode
                    if let jsonStr = try? JSONSerialization.jsonObject(with: usableData, options: .allowFragments)
                    {
                        if let dataStr = jsonStr as? String
                        {
                            let dataDict : [String : Any] = ["data" : dataStr]
                            completionData(dataDict, statusCode!)
                        }
                        if let dataValue = jsonStr as? Bool
                        {
                            let dataDict : [String : Any] = ["data" : dataValue]
                            completionData(dataDict, statusCode!)
                        }
                    }
                    let json = try? JSONSerialization.jsonObject(with: usableData, options: [])
                    if let arr = json as? [Any]
                    {
                        let dataDict : [String : Any] = ["data" : arr]
                        completionData(dataDict, statusCode!)
                    }
                    if let dictionary = json as? [String : Any]
                    {
                        completionData(dictionary, statusCode!)
                    }
                }
            }
        })
        task.resume()
    }
    
    
    
    private func prepareUrlRequest(request : Request,path: String = "") throws -> URLRequest
    {
        var pathApi = self.configuration.pathApi
        if path != ""
        {
            pathApi = path
        }
       let urlStr = "\(self.configuration.baseUrl)\(pathApi)\(request.endPoint.rawValue)"
        guard let url = URL.init(string: urlStr) else { throw NetworkError.invalidURL(urlStr) }
        var urlRequest = URLRequest.init(url: url, cachePolicy: request.cachePolicy!, timeoutInterval: request.timeout!)
        if let urlParam = request.urlParams as? [String : String]
        {
            let query_params = urlParam.map({ (element) -> URLQueryItem in
                return URLQueryItem(name: element.key, value: element.value)
            })
            guard var components = URLComponents(string: urlStr) else {
                throw NetworkError.invalidURL(urlStr)
            }
            components.queryItems = query_params
            urlRequest.url = components.url
        }
        else
        {
            
        }
        urlRequest.httpMethod = request.method.rawValue
        if let headers = request.headers
        {
            for (key, value) in headers
            {
                urlRequest.addValue(value, forHTTPHeaderField: key)
            }
        }
        if let body = request.body
        {
            let bodyData = try? body.encodedData()
            urlRequest.httpBody = bodyData
        }
        
        return urlRequest
    }
    
    //MARK: Get image from url
    public func getImageFromUrl(url : String, completionData: @escaping (_ image : UIImage) -> Void)
    {
       
        guard let url = URL.init(string: url) else { return }
        if url.pathExtension.contains("gif")
        {

            completionData(UIImage.gifImageWithURL(url)!)

        }
        else {
        let getImageFromUrl = self.session.dataTask(with: url) { (data, response, error) in

            //if there is any error
            if let e = error {
                //displaying the message
                print("Error Occurred: \(e)")

            } else {
                //in case of now error, checking wheather the response is nil or not
                if (response as? HTTPURLResponse) != nil {

                    //checking if the response contains an image
                    if let imageData = data {

                        //getting the image
                        if let image = UIImage(data: imageData) {
                        completionData(image)
                        }
                    } else {
                        print("Image file is currupted")
                    }
                } else {
                    print("No response from server")
                }
            }
        }

        //starting the download task
        getImageFromUrl.resume()
    }
        
        
       
        
        
        
  }
    
    
   
    
}

