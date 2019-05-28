//
//  AlbumsViewController.swift
//  RSSFeed
//
//  Created by Chinna Addepally on 5/24/19.
//  Copyright © 2019 Chinna Addepally. All rights reserved.
//

import UIKit

class AlbumsViewController: UIViewController {
    
    var tableView: UITableView?
    var albums: [Album] = []
    
    var presenter: AlbumsViewPresenter?
    var router: AlbumsViewRouter?
    
    func configurePresenter() {
        //Configure Interactor
        let interactor = AlbumsViewInteractor()
        
        //Configure Presenter
        presenter = AlbumsViewPresenter(albumsInteractor: interactor)
        presenter!.delegate = self
        
        //Configure Router
        router = AlbumsViewRouter(viewController: self)
    }
    
    func configureTableView() {
        tableView = UITableView.init(frame: CGRect.zero)
        tableView?.translatesAutoresizingMaskIntoConstraints = false
        tableView?.register(AlbumTableViewCell.self, forCellReuseIdentifier: "Album")
    }
    
    func reloadData() {
        tableView?.reloadData()
    }
    
    func loadAlbums() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        presenter?.fetchAlbums(count: 100)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Albums"
        configurePresenter()
        
        //Load RSS Feed
        loadAlbums()
    }
}


extension AlbumsViewController: AlbumsViewProtocol {
    func albumsFetched(albums: [Album]) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        self.albums = albums
        reloadData()
    }
}

extension AlbumsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Album") as! AlbumTableViewCell
        cell.createViews()
        cell.createConstraints()
        
        let album = albums[indexPath.row]
        cell.configureCell(album: album)
        return cell
    }
}

extension AlbumsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Navigate to detail View Controller
    }
}
