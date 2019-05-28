//
//  AlbumsViewInteractor.swift
//  RSSFeed
//
//  Created by Chinna Addepally on 5/25/19.
//  Copyright © 2019 Chinna Addepally. All rights reserved.
//

import Foundation

fileprivate var albumsURL = "https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/%@/explicit.json"

class AlbumsViewInteractor {
    
    func fetchAlbums(count: Int, completion: @escaping(Bool, [Album]?, RSSError?) -> ()) {
        let url = String(format: albumsURL, "\(count)")
        let request = AlbumRequestObject.init(albumURL: url)
        
        NetworkManager().send(r: request) { (success, response, error) in
            if success {
                guard let responseDictionary = response?.responseDictionary, let feed = responseDictionary["feed"] as? [String: Any], let results = feed["results"] as? [[String: Any]] else {
                    completion(success, nil, error)
                    return
                }
                
                let albums = results.compactMap({ (albumInfo) -> Album in
                    return Album.init(albumDictionary: albumInfo)
                })
                
                completion(success, albums, nil)
            }
            else {
                completion(success, nil, error)
            }
        }
    }
    
}
