//
//  AlbumDetailViewController.swift
//  RSSFeed
//
//  Created by Chinna Addepally on 5/24/19.
//  Copyright © 2019 Chinna Addepally. All rights reserved.
//

import UIKit

class AlbumDetailViewController: UIViewController {
    
    var selectedAlbum: Album!
    
    var artworkDetailView: UIImageView!
    var genreLabel: UILabel!
    var releaseDateLabel: UILabel!
    var copyrightLabel: UILabel!
    
    var iTunesLink: UIButton!
    
    func createViews() {
        createArtworkDetailView()
        createGenreLabel()
        createReleaseDateLabel()
        createCopyrightLabel()
        createiTunesLink()
    }
    
    func createConstraints() {
        let viewsDict: [String: Any] = ["Artwork": artworkDetailView!, "Genre": genreLabel!, "ReleaseDate": releaseDateLabel!, "Copyright": copyrightLabel!, "iTunes": iTunesLink!]
        
        view.addConstraints([NSLayoutConstraint.init(item: artworkDetailView!, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)])
        
        view.addConstraints([NSLayoutConstraint.init(item: genreLabel!, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)])

        view.addConstraints([NSLayoutConstraint.init(item: releaseDateLabel!, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)])

        view.addConstraints([NSLayoutConstraint.init(item: copyrightLabel!, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)])

        view.addConstraint(NSLayoutConstraint.init(item: artworkDetailView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[iTunes]-20-|", options: .init(rawValue: 0), metrics: nil, views: viewsDict))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-100-[Artwork(200)]-50-[Genre]-12-[ReleaseDate]-12-[Copyright]-10@200-[iTunes(44)]-|", options: .init(rawValue: 0), metrics: nil, views: viewsDict))
    }
    
    @objc func navigateToiTunes() {
        guard let artistURLString = selectedAlbum.artistUrl, let url = URL(string: artistURLString), UIApplication.shared.canOpenURL(url) else {
            return
        }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        title = selectedAlbum.name
        
        createViews()
        createConstraints()
    }
}
