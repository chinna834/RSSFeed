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
        interactor.fetchAlbums(count: count) { [weak self] (success, albums, error) in
            if success {
                guard let albumsInfo = albums else {
                    self?.delegate?.albumsFetched(albums: [])
                    return
                }
                self?.delegate?.albumsFetched(albums: albumsInfo)
            }
            else {
                self?.delegate?.albumsFetched(albums: [])
            }
        }
    }
}
