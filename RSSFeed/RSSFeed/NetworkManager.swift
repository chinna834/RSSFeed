//
//  NetworkManager.swift
//  RSSFeed
//
//  Created by Chinna Addepally on 5/24/19.
//  Copyright © 2019 Chinna Addepally. All rights reserved.
//

import Foundation

enum httpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}

protocol RequestObject {
    var url: URL{get}
    var host: String{get}
    var path: String{get}
    var method: String{get}
    var body: [String: Any]? {get}
    var headers: [[String: Any]]? {get}
    
    associatedtype response: ResponseObject
}

protocol ResponseObject {
    static func parse(data: Data, success: Bool) -> Self?
}

class RSSError: NSObject {
    var errorDescription: String!
    var errorCode: Int!
    var serverError: Error!
    
    override init() {
        super.init()
    }
    
    convenience init(description: String, responseCode: Int, error: Error?) {
        self.init()
        self.errorDescription = description
        self.errorCode = responseCode
        self.serverError = error
    }
}

extension Error {
    var code: Int { return (self as NSError).code }
}

typealias Completion<T: RequestObject> = (_ success: Bool, _ response: T.response?, _ error: RSSError?) -> ()

class NetworkManager {
    
    static let networkManager = NetworkManager()
    
    
    func send<T: RequestObject>(r: T, completion:@escaping Completion<T>) {
        //yet to be done
        
        let url = r.url
        
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = 30
        urlRequest.httpMethod = r.method
        
        if r.headers != nil {
            for header in r.headers! {
                let key = header.keys.first!
                urlRequest.addValue((header[key] as? String)!, forHTTPHeaderField: key)
            }
        }
        
        if r.body != nil {
            let body = try! JSONSerialization.data(withJSONObject: r.body!, options: .init(rawValue: 0))
            let bodyString = String(data: body, encoding: .utf8)
            urlRequest.httpBody = bodyString?.data(using: .utf8)
        }
        
        let sessionConfig = URLSessionConfiguration.default
        let urlSession = URLSession.init(configuration: sessionConfig, delegate: nil, delegateQueue: .main)
        let sessionDataTask = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            if let err = error {
                print("Error: \(err)")
            }
            
            guard error == nil else {
                completion(false, nil, RSSError(description: (error?.localizedDescription)!, responseCode: (error?.code)!, error: error!))
                return
            }
            
            guard response is HTTPURLResponse else{
                completion(false, nil, RSSError())
                return
            }
            
            guard (response as! HTTPURLResponse).statusCode != 404 else {
                completion(false, nil, RSSError(description: "Something went wrong, Please try again.", responseCode: (response as! HTTPURLResponse).statusCode, error: error))
                return
            }
            guard (response as! HTTPURLResponse).statusCode != 400 else {
                completion(false, nil, RSSError(description: "Something went wrong, Please try again.", responseCode: (response as! HTTPURLResponse).statusCode, error: error))
                return
            }
            guard (response as! HTTPURLResponse).statusCode != 401 else {
                completion(false, nil, RSSError(description: "Something went wrong, Please try again.", responseCode: (response as! HTTPURLResponse).statusCode, error: error))
                return
            }
            guard (response as! HTTPURLResponse).statusCode != 502 else {
                completion(false, nil, RSSError(description: "Something went wrong, Please try again.", responseCode: (response as! HTTPURLResponse).statusCode, error: error))
                return
            }
            guard (response as! HTTPURLResponse).statusCode != 500 else {
                completion(false, nil, RSSError(description: "Something went wrong, Please try again.", responseCode: (response as! HTTPURLResponse).statusCode, error: error))
                return
            }
            
            guard data != nil else {
                completion(false, nil, RSSError())
                return
            }
            
            guard (response as! HTTPURLResponse).statusCode == 200 else {
                let res = T.response.parse(data: data!, success: false)
                completion(false, res, nil)
                return
            }
            
            let res = T.response.parse(data: data!, success: true)
            guard res != nil else {
                completion(false, res, RSSError())
                return
            }
            
            completion(true, res, nil)
        }
        
        sessionDataTask.resume()
    }
}
