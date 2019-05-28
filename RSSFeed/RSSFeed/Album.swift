//
//  Album.swift
//  RSSFeed
//
//  Created by Chinna Addepally on 5/25/19.
//  Copyright © 2019 Chinna Addepally. All rights reserved.
//

import Foundation
import UIKit

class Album {
    
    let artistId: NSInteger?
    let artistName: String?
    let artistUrl: String?
    let artworkUrl100: String?
    let contentAdvisoryRating: String?
    let copyright: String?
    var genres: [Genre] = []
    let id: NSInteger?
    let kind: String?
    let name: String?
    let releaseDate: String?
    let url: String?
    
    var artworkImage: UIImage?
    
    init(albumDictionary: [String: Any]) {
        artistId = albumDictionary["artistId"] as? NSInteger
        print(artistId)
        
        artistName = albumDictionary["artistName"] as? String
        artistUrl = albumDictionary["artistUrl"] as? String
        artworkUrl100 = albumDictionary["artworkUrl100"] as? String
        contentAdvisoryRating = albumDictionary["contentAdvisoryRating"] as? String
        copyright = albumDictionary["copyright"] as? String
        
        if let genreInfo = albumDictionary["genres"] as? [[String: Any]] {
            genres = genreInfo.compactMap({ (genreDict) -> Genre? in
                return Genre.init(genreDictionary: genreDict)
            })
        }
        
        id = albumDictionary["id"] as? NSInteger
        print(id)
        
        kind = albumDictionary["kind"] as? String
        name = albumDictionary["name"] as? String
        releaseDate = albumDictionary["releaseDate"] as? String
        url = albumDictionary["url"] as? String
    }
    
    
    func downloadImage(completed: @escaping(UIImage?) -> ()) {
        guard artworkImage == nil else {
            completed(artworkImage)
            return
        }
        
        guard let thumbImageString = artworkUrl100, let thumbImageURL = URL(string: thumbImageString) else {
            completed(nil)
            return
        }
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: thumbImageURL) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async { [weak self] in
                        self?.artworkImage = image
                        completed(self?.artworkImage)
                    }
                }
            }
        }
    }
}


