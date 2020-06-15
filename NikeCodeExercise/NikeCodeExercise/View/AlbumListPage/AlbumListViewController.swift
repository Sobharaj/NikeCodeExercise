//
//  AlbumListViewController.swift
//  NikeCodeExercise
//
//  Created by Sobharaj on 6/10/20.
//  Copyright © 2020 Home. All rights reserved.
//

import UIKit
import Foundation

class AlbumListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource  {
    
    /// This struct is to hold the  AlbumListViewModel Dependancy
    struct Dependencies {
        var viewModel : AlbumListViewModel?
    }
    
    /// Creating the refrence of Dependencies  struct
    var dependencies: Dependencies
    
    
    /// Creating the refrence of UITableView
    lazy var tblViewAlbum: UITableView = {
        return customTableView()
    }()
    
    /// Creating the refrence of UILabel for displaying message(Error, Data loaging status)
    lazy var messageLabel: UILabel = {
        return customLabel(appBoldFont(size: 14))
    }()
    
    /// Creating the refrence of UIActivityIndicatorView
    lazy var loadingIndicator: UIActivityIndicatorView = {
        return customIndicator()
    }()
    
    
    
    //MARK: - View Life Cycle Method
    
    /// This method Called after the controller's view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // This method called to initaialize the UI
        self.initializeUI()
        
        // This method called to add Observer for dataBinding
        self.initDataBinding()
        
        // This method called to start loading Feed data
        self.startLoadingFeedData()
    }
    
    /// This method Called at the time of initialization of the controller
    ///
    /// - Parameters:
    ///   - dependencies: Dependencies parameter  for the controller
    init(dependencies: Dependencies = .init()) {
        self.dependencies = dependencies
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError(StringKey.INIT_FATAL_ERROR)
    }
    
    //MARK: - General Method
    
    /// This method is responsible for loading feed data
    func startLoadingFeedData()  {
        // This will call the loadingFeed method of AlbumListViewModel class
        self.dependencies.viewModel?.loadingFeed()
    }
    
    /// This method is responsible for Initialize all UIComponent
    private  func initializeUI()  {
        // Set the Page Title
        self.title = StringKey.ALBUM_PAGETITLE
        
        // Set the backgroundColor of the view
        self.view.backgroundColor = .white
        
        // This method call to add the Layouts and Constraint
        self.setupUILauoutConstraint()
    }
    
    /// This method is responsbile for  adding the Layouts and Constraint
    private  func setupUILauoutConstraint() {
        
        // Register the tblViewAlbum cell
        tblViewAlbum.register(AlbumListCell.self, forCellReuseIdentifier: StringKey.ALBUM_LISTCELL)
        
        //Adding tblViewAlbum in Self.View
        view.addSubview(tblViewAlbum)
        
        // Setting the delegate and datasource of tblViewAlbum
        tblViewAlbum.delegate = self
        tblViewAlbum.dataSource = self
        
        // Setting the constraint of tblViewAlbum
        NSLayoutConstraint.activate([
            tblViewAlbum.topAnchor.constraint(equalTo: self.view.topAnchor),
            tblViewAlbum.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tblViewAlbum.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tblViewAlbum.leftAnchor.constraint(equalTo: self.view.leftAnchor)])
                
        //Adding messageLabel in Self.View
        self.view.addSubview(messageLabel)
        
        // Setting the constraint of messageLabel
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
        ])
        
        //Adding loadingIndicator in Self.View
        self.view.addSubview(loadingIndicator)
        
        // Setting the constraint of loadingIndicator
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        
    }
    
    // This method is responsible for adding Observer for dataBinding
    private func initDataBinding() {
        
        // This will fire if there is any achange of value in rowViewModels object
        self.dependencies.viewModel?.rowViewModels.addObserver { [weak self] (rowViewModels) in
            DispatchQueue.main.async {
                //Reload the tblViewAlbum if the rowViewModels value got change
                self?.tblViewAlbum.reloadData()
            }
        }
        // This will fire if there is any achange of value in title object
        self.dependencies.viewModel?.title.addObserver { [weak self] (title) in
            DispatchQueue.main.async {
                // Set the title
                self?.messageLabel.text = title
            }
        }
        
        // This will fire if there is any achange of value in isTableViewHidden object
        self.dependencies.viewModel?.isTableViewHidden.addObserver { [weak self] (isHidden) in
            DispatchQueue.main.async {
                // Maintain the isHidden status of tblViewAlbum
                self?.tblViewAlbum.isHidden = isHidden
                // Maintain the isHidden status of messageLabel
                self?.messageLabel.isHidden = !isHidden
            }
        }
        
        // This will fire if there is any achange of value in isLoading object
        self.dependencies.viewModel?.isLoading.addObserver{ [weak self] (isLoading) in
            DispatchQueue.main.async {
                if isLoading {// isLoading is true
                    self?.loadingIndicator.startAnimating()
                } else { // isLoading is false
                    self?.loadingIndicator.stopAnimating()}
            }
        }
    }
    
    //MARK: - UITableView Delegate and DataSource Method

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // This will return the rowViewModels value count
        return self.dependencies.viewModel?.rowViewModels.value.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StringKey.ALBUM_LISTCELL) as? AlbumListCell else {
            return UITableViewCell()
        }
        // Find the AlbumCellViewModel
        if let viewModel = self.dependencies.viewModel?.rowViewModels.value[indexPath.row] {
            //This method will call to Load the AlbumCellViewModel data in  AlbumListCell
            cell.loadData(viewModel: viewModel)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Create the dependency object for AlbumDetailViewController
        let dependencies = AlbumDetailViewController.Dependencies(albumViewModel: self.dependencies.viewModel?.rowViewModels.value[indexPath.row])
        
        // Create the refernce of AlbumDetailViewController and initialize it
        let detailViewController = AlbumDetailViewController(dependencies: dependencies)
        
        // Navigate to AlbumDetailViewController
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}

