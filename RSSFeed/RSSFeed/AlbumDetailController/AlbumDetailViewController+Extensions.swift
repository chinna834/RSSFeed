//
//  AlbumDetailViewController+Extensions.swift
//  RSSFeed
//
//  Created by Chinna Addepally on 5/28/19.
//  Copyright © 2019 Chinna Addepally. All rights reserved.
//

import Foundation
import UIKit

extension AlbumDetailViewController {
    
    func createLabel() -> UILabel {
        let label = UILabel.init(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }
    
    func createArtworkDetailView() {
        
        artworkDetailView = UIImageView(frame: CGRect.zero)
        artworkDetailView.translatesAutoresizingMaskIntoConstraints = false
        artworkDetailView.contentMode = .scaleAspectFit
        if let image = selectedAlbum.artworkImage {
            artworkDetailView.image = image
        }
        view.addSubview(artworkDetailView)
    }
    
    func createGenreLabel() {
        genreLabel = createLabel()
        genreLabel.font = UIFont.systemFont(ofSize: 17)
        genreLabel.textColor = UIColor.darkGray
        var concatenated = ""
        
        for genre in selectedAlbum.genres {
            if let name = genre.name {
                concatenated.append(name + " ")
            }
        }
        
        genreLabel.text = concatenated
        
        view.addSubview(genreLabel)
    }
    
    func createReleaseDateLabel() {
        releaseDateLabel = createLabel()
        releaseDateLabel.font = UIFont.systemFont(ofSize: 15)
        releaseDateLabel.textColor = UIColor.lightGray
        
        releaseDateLabel.text = "Released on \(selectedAlbum.releaseDate ?? "")"
        
        view.addSubview(releaseDateLabel)
    }
    
    func createCopyrightLabel() {
        copyrightLabel = createLabel()
        copyrightLabel.font = UIFont.systemFont(ofSize: 14)
        copyrightLabel.textColor = .lightGray
        copyrightLabel.numberOfLines = 0
        copyrightLabel.preferredMaxLayoutWidth = UIScreen.main.bounds.size.width-20
        copyrightLabel.text = selectedAlbum.copyright
        
        view.addSubview(copyrightLabel)
    }
    
    func createiTunesLink() {
        iTunesLink = UIButton.init(frame: CGRect.zero)
        iTunesLink.translatesAutoresizingMaskIntoConstraints = false
        iTunesLink.setTitle("iTunes", for: .normal)
        iTunesLink.backgroundColor = UIColor.blue
        iTunesLink.setTitleColor(.white, for: .normal)
        iTunesLink.addTarget(self, action: #selector(navigateToiTunes), for: .touchUpInside)
        iTunesLink.layer.cornerRadius = 4
        view.addSubview(iTunesLink)
    }
}
