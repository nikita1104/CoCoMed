//
//  WebviewManager.swift
//  CoCoMed
//
//  Created by Nikita Srivastava on 18/05/20.
//  Copyright © 2020 LifeSparkTech. All rights reserved.
//

import Foundation
import WebKit

class WebViewManager: NSObject, WebDispatcherProtocol {
    
    func createWebView(frame: CGRect, userContent : [Any]?, target : Any) -> WKWebView {
        let config = WKWebViewConfiguration.init()
        config.preferences.setValue(true, forKey: "allowFileAccessFromFileURLs")
        if userContent != nil
        {
            for content in userContent!
            {
                config.userContentController.add(target as! WKScriptMessageHandler, name: content as! String)
            }
        }
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        preferences.javaScriptCanOpenWindowsAutomatically = true
        config.preferences = preferences
        let webView = WKWebView.init(frame: frame, configuration: config)
        webView.navigationDelegate = target as? WKNavigationDelegate
        webView.uiDelegate = target as? WKUIDelegate
        return webView
    }
     
    func getUrlRequest(request : WebRequest) -> URLRequest?
    {
        if let request = try? prepareWebRequest(request: request)
        {
            return request
        }
        return nil
    }
    
    private func prepareWebRequest(request : WebRequest) throws -> URLRequest
    {
        guard let appCfg = Bundle.main.object(forInfoDictionaryKey: ServerConfig.endpoint.rawValue) as? [String : Any] else { throw NetworkError.invalidURL("") }
        guard let base = appCfg[ServerConfig.webbase.rawValue] else { throw NetworkError.invalidURL("") }
      let urlStr = "\(base as! String)\(request.endPoint)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
      //let urlStr = "https://e51f1cc0.ngrok.io\(request.endPoint)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
       
        guard let url = URL.init(string: urlStr!)else {throw NetworkError.invalidURL(urlStr!)}
       
        var urlRequest = URLRequest.init(url: url)
        
        if let urlParam = request.urlParams as? [String : String]
        {
            let query_params = urlParam.map({ (element) -> URLQueryItem in
                return URLQueryItem(name: element.key, value: element.value)
            })
            guard var components = URLComponents(string: urlStr!) else {
                throw NetworkError.invalidURL(urlStr!)
            }
            components.queryItems = query_params
            urlRequest.url = components.url
        }
        if let headers = request.headers
        {
            for (key, value) in headers
            {
                urlRequest.addValue(value, forHTTPHeaderField: key)
            }
        }
       
        return urlRequest
    }
}


protocol WebDispatcherProtocol {
    func createWebView(frame : CGRect, userContent : [Any]?, target : Any) -> WKWebView
    func getUrlRequest(request : WebRequest) -> URLRequest?
}

