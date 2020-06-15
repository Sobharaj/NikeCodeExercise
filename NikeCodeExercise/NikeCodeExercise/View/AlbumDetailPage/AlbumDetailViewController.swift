//
//  AlbumDetailViewController.swift
//  NikeCodeExercise
//
//  Created by Sobharaj on 6/12/20.
//  Copyright © 2020 Home. All rights reserved.
//

import UIKit

class AlbumDetailViewController: UIViewController, AlbumDetailViewDelegate {
    
    /// This struct is to hold the  AlbumCellViewModel Dependancy
    struct Dependencies {
        var albumViewModel : AlbumCellViewModel?
    }
    
    /// dependencies is the refrence of Dependencies  struct
    var dependencies: Dependencies

    /// viewModel is the refrence of AlbumDetailViewModel
    lazy var  viewModel = AlbumDetailViewModel()
    
    /// albumDetailView is  the refrence of AlbumDetailView
    lazy  var albumDetailView : AlbumDetailView = {
        // Initialize the AlbumDetailView
        let detailView = AlbumDetailView()
        // Set the delgate of detailView toAlbumDetailViewController
        detailView.delegate = self
        return  detailView}()
    
    //MARK: - View Life Cycle Method

    /// This method Called after the controller's view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        // This method called to initaialize the UI
        self.initializeUI()
        
        // This method to load album Data
        self.loadAlbumData()
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
    /// This method is responsible for  calling the loadAlbumData method of viewModel
    func loadAlbumData()  {
        // Call the loadAlbumData of AlbumDetailViewModel
        viewModel.loadAlbumData(with: self.dependencies.albumViewModel)
    }
    
    /// This method is responsible for Initialize all UIComponent
    func initializeUI()  {
        // Set the Page Title
        self.title = StringKey.ALBUMDETAIL_PAGETITLE

        // Set the backgroundColor of the view
        self.view.backgroundColor = .white
        
        // This method call to add the Layouts and Constraint
        self.setupUILauoutConstraint()
        
        // This method called to add observer for Data Binding
        self.initDataBinding()
    }
    
    /// This method is responsible to open the albumUrl in iTune
    func openAlbumInItune() {
        guard let albumUrl = self.dependencies.albumViewModel?.albumUrl  else {return}
        if let url = URL(string:albumUrl) {
            UIApplication.shared.open(url)}
    }
    
    /// This method is responsbile for  adding the Layouts and Constraint
    func setupUILauoutConstraint()  {
        
        //Adding albumDetailView in Self.View
        self.view.addSubview(albumDetailView)
        
        // Setting the constraint of albumDetailView
        NSLayoutConstraint.activate([
            albumDetailView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            albumDetailView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            albumDetailView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            albumDetailView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)])
    }
    
    // This method is responsible for adding Observer for dataBinding
    private func initDataBinding() {
        
        // This will fire if there is any achange of value in AlbumCellViewModel object
        viewModel.rowViewModels.addObserver { [weak self] (detailModel) in
          
            // Set the image on artWorkImageView
            self?.albumDetailView.artWorkImageView.image = detailModel?.image.image
            // Start downloading the image
            detailModel?.image.startDownload()
            // Once download of image completed , set to the thumbnailImageView
            detailModel?.image.completeDownload = { [weak self] image in
                self?.albumDetailView.artWorkImageView.image = image
            }
            
            // Set the albumName value to albumNameValueLabel
            self?.albumDetailView.albumNameValueLabel.text = detailModel?.albumName

            // Set the artistName value to artistNameValueLabel
            self?.albumDetailView.artistNameValueLabel.text = detailModel?.artistName
            
            // Set the genre value to genreValueLabel
            self?.albumDetailView.genreValueLabel.text =  detailModel?.genre
            
            // Set the releaseDate value to releaseDateValueLabel
            self?.albumDetailView.releaseDateValueLabel.text = detailModel?.releaseDate
            
            // Set the copyRight value to copyRightValueLabel
            self?.albumDetailView.copyRightValueLabel.text =  detailModel?.copyRight
        }
    }
    
    
    deinit {
        print("AlbumDetailViewController--Deinit")
    }


}
