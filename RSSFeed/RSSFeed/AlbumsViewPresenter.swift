//
//  AlbumsViewPresenter.swift
//  RSSFeed
//
//  Created by Chinna Addepally on 5/25/19.
//  Copyright © 2019 Chinna Addepally. All rights reserved.
//

import Foundation

protocol AlbumsViewProtocol: class {
    func albumsFetched(albums: [Album])
}

class AlbumsViewPresenter {
    
    let interactor: AlbumsViewInteractor
    weak var delegate: AlbumsViewProtocol?
    
    init(albumsInteractor: AlbumsViewInteractor) {
        interactor = albumsInteractor
    }
    
    func fetchAlbums(count: Int) {
        let request = AlbumRequestObject.init(albumURL: "https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/2/explicit.json")
        NetworkManager().send(r: request) { (success, response, error) in
            if success {
                
            }
            else {
                
            }
        }
    }
    
    
}
