//
//  AlbumsViewRouter.swift
//  RSSFeed
//
//  Created by Chinna Addepally on 5/26/19.
//  Copyright © 2019 Chinna Addepally. All rights reserved.
//

import Foundation
import UIKit

class AlbumsViewRouter {
    
    let target: AnyObject
    
    init(viewController: AlbumsViewController) {
        target = viewController
    }
    
    func navigateToAlbumDetailViewController(selectedAlbum: Album) {
        //Navigate to detail view controller
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let albumDetailViewController = storyboard.instantiateViewController(withIdentifier: "AlbumDetail") as! AlbumDetailViewController
        albumDetailViewController.selectedAlbum = selectedAlbum
        target.navigationController??.pushViewController(albumDetailViewController, animated: true)
    }
    
}
