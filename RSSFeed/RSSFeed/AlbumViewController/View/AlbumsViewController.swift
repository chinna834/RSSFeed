//
//  AlbumsViewController.swift
//  RSSFeed
//
//  Created by Chinna Addepally on 5/24/19.
//  Copyright © 2019 Chinna Addepally. All rights reserved.
//

import UIKit

class AlbumsViewController: UIViewController {
    
    var tableView: UITableView!
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
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: "Album")
        tableView.estimatedRowHeight = 70
        tableView.clipsToBounds = false
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
    }
    
    func createConstraints() {
        let viewsDict: [String: Any] = ["Albums": tableView!]
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[Albums]|", options: .init(rawValue: 0), metrics: nil, views: viewsDict))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[Albums]|", options: .init(rawValue: 0), metrics: nil, views: viewsDict))
    }
    
    func reloadData() {
        tableView?.reloadData()
    }
    
    func loadAlbums() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        presenter?.fetchAlbums(count: 100)
    }
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Albums"
        
        configurePresenter()
        
        //Configure Table View
        configureTableView()
        createConstraints()
        
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Album") as? AlbumTableViewCell else {
            return UITableViewCell()
        }
        cell.createViews()
        cell.createConstraints()
        
        cell.accessoryType = .disclosureIndicator
        
        let album = albums[indexPath.row]
        cell.configureCell(album: album)
        return cell
    }
}

extension AlbumsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Navigate to detail View Controller
        
        let selectedAlbum = albums[indexPath.row]
        router?.navigateToAlbumDetailViewController(selectedAlbum: selectedAlbum)
    }
}
