//
//  AlbumTableViewCell.swift
//  RSSFeed
//
//  Created by Chinna Addepally on 5/26/19.
//  Copyright © 2019 Chinna Addepally. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    
    var albumName: UILabel!
    var artistName: UILabel!
    var albumImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(album: Album) {
        albumName.text = album.name
        artistName.text = album.artistName
        
        album.downloadImage { [weak self] (downloadedImage) in
            self?.albumImageView.image = downloadedImage
        }
    }
    
    func createLabel() -> UILabel {
        let label = UILabel.init(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func createViews() {
        if albumName == nil {
            albumName = createLabel()
            albumName.textColor = UIColor.darkGray
            albumName.font = UIFont.systemFont(ofSize: 17)
        }
        addSubview(albumName)
        
        if artistName == nil {
            artistName = createLabel()
            artistName.textColor = UIColor.lightGray
            artistName.font = UIFont.systemFont(ofSize: 14)
        }
        addSubview(artistName)
        
        if albumImageView == nil {
            albumImageView = UIImageView(frame: CGRect.zero)
            albumImageView.translatesAutoresizingMaskIntoConstraints = false
        }
        addSubview(albumImageView)
    }
    
    func createConstraints() {
        
        guard albumName != nil, artistName != nil, albumImageView != nil else {
            return
        }
        
        let viewsDict: [String: Any] = ["Album": albumName!, "Artist": artistName!, "AlbumImage": albumImageView!]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[AlbumImage(100)]-10-|", options: .init(rawValue: 0), metrics: nil, views: viewsDict))
        
        addConstraint(NSLayoutConstraint.init(item: albumImageView!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100))
        
//        addConstraint(NSLayoutConstraint.init(item: albumImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100))
        
        addConstraint(NSLayoutConstraint.init(item: albumName!, attribute: .top, relatedBy: .equal, toItem: albumImageView, attribute: .top, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint.init(item: albumName!, attribute: .leading, relatedBy: .equal, toItem: albumImageView, attribute: .leading, multiplier: 1, constant: 10))

        addConstraint(NSLayoutConstraint.init(item: artistName!, attribute: .bottom, relatedBy: .equal, toItem: albumImageView, attribute: .bottom, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint.init(item: artistName!, attribute: .leading, relatedBy: .equal, toItem: artistName, attribute: .leading, multiplier: 1, constant: 0))
    }
    
   
}
