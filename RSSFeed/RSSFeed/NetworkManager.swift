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
    static func parse(data: Data, succes: Bool) -> Self?
}

typealias Completion<T: RequestObject> = (_ success: Bool, _ response: T.response?, _ error: RSSError?) -> ()

class RSSError: NSObject {
    var errorDescription: String!
    var errorCode: Int!
    var serverError: Error!
    
    override init() {
        super.init()
    }
    
    convenience init(description: String, responseCode: Int, error: Error) {
        self.init()
        self.errorDescription = description
        self.errorCode = responseCode
        self.serverError = error
    }
}

class NetworkManager {
    
    static let networkManager = NetworkManager()
    
    
    
    func send<T: RequestObject>(r: T, completion:@escaping Completion<T>) {
        //yet to be done
    }
    
}
