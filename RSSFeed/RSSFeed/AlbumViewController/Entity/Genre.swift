//
//  Genre.swift
//  RSSFeed
//
//  Created by Chinna Addepally on 5/27/19.
//  Copyright © 2019 Chinna Addepally. All rights reserved.
//

import Foundation

struct Genre {
    let genreId: String?
    let name: String?
    let url: String?
    
    init(genreDictionary: [String: Any]) {
        genreId = genreDictionary["genreId"] as? String
        name = genreDictionary["name"] as? String
        url = genreDictionary["url"] as? String
    }
}
