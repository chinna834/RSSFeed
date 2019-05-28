//
//  AlbumRequestResponse.swift
//  RSSFeed
//
//  Created by Chinna Addepally on 5/25/19.
//  Copyright © 2019 Chinna Addepally. All rights reserved.
//

import Foundation

struct AlbumRequestObject: RequestObject {
    var url: URL
    var host: String = ""
    var path: String = ""
    var method: String = httpMethod.get.rawValue
    var body: [String : Any]?
    var headers: [[String : Any]]?
    
    typealias response = AlbumResponseObject
    
    init(albumURL: String) {
        url = URL(string: albumURL)!
    }
}

struct AlbumResponseObject: ResponseObject {
    
    var responseDictionary: [String: Any]?
    var error: RSSError?
    
    static func parse(data: Data, success: Bool) -> AlbumResponseObject? {
        var response = AlbumResponseObject()
        
        if success {
            let responseDictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
            guard let albumsResponseDictionary = responseDictionary as? [String: Any] else { return response }
            response.responseDictionary = albumsResponseDictionary
        }
        else {
            response.error = RSSError()
        }
        return response
    }
}
