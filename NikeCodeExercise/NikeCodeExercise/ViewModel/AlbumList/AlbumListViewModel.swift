//
//  AlbumListViewModel.swift
//  NikeCodeExercise
//
//  Created by Sobharaj on 6/11/20.
//  Copyright © 2020 Home. All rights reserved.
//

import UIKit

class AlbumListViewModel {
    
    // Creating Observable title reference
    let title = Observable<String>(value: StringKey.LOADING)
    
    // Creating Observable isLoading reference
    let isLoading = Observable<Bool>(value: false)
    
    // Creating Observable isTableViewHidden reference
    let isTableViewHidden = Observable<Bool>(value: false)
    
    // Creating Observable rowViewModels reference
    let rowViewModels = Observable<[AlbumCellViewModel]>(value: [])
    
    
    /// This struct is to hold the  AlbumListViewModel Dependancy
    struct Dependencies {
        var albumService : AlbumService?
    }
    /// Creating the refrence of Dependencies  struct
    let dependencies: Dependencies

    /// This method Called at the time of initialization of the controller
    ///
    /// - Parameters:
    ///   - dependencies: Dependencies parameter  for the controller
    init(dependencies: Dependencies = .init()) {
        self.dependencies = dependencies
    }

    /// This method id responsible for Loading the Feed
    func loadingFeed() {
        // Set the isLoading value to true
        isLoading.value = true

        // Set the isTableViewHidden value to true
        isTableViewHidden.value = true

        // Set the title value to true
        title.value = StringKey.LOADING_PROGRESS
        
        // Create a bckground thread to call the fetchFeedData method
        DispatchQueue.global(qos: .background).async {
            self.fetchFeedData()
        }
    }
    
    /// This method is responsible for calling the fetchMusicFeed method of albumService and get the response
    func fetchFeedData()  {
        self.dependencies.albumService?.fetchMusicFeed(completion: { data, error in
            if(error != nil){// If error is there
                self.title.value = error?.localizedDescription ?? StringKey.UNKNOWN_ERROR
                self.isLoading.value = false
            }
           else if(data != nil){ // If data is there
                    self.isLoading.value = false
                    self.isTableViewHidden.value = false
                    self.buildAlbumCellViewModel(albums: data)
            }else{
                self.title.value = StringKey.UNKNOWN_ERROR
                self.isLoading.value = false
            }
        })
    }
    
    /// This method is responsible for preparing AlbumCellViewModel
    ///
    /// - Parameters:
    ///   - albums: reference of AlbumModel
    func buildAlbumCellViewModel(albums: AlbumModel?) {
        var rows = [AlbumCellViewModel]()

        if let newAlbums = albums?.feed?.results{
            for album in newAlbums {
                let strGenre = album.genres?.map({ (genre: AlbumModel.Genre) -> String in
                    (genre.name ?? "")
                }).filter({ (strName: String) -> Bool in
                    strName.count > 0
                }).joined(separator: ", ")
                
                // Create the AlbumCellViewModel object
                let rowModel = AlbumCellViewModel(albumName: album.name ?? StringKey.NA,
                                                  artistName: album.artistName ?? StringKey.NA,
                                                  image: AsyncImage(url: album.artworkUrl100 ?? ""),
                                                  releaseDate:album.releaseDate ?? StringKey.NA,
                                                  copyRight:album.copyright ?? StringKey.NA,
                                                  genre: strGenre ?? "",albumUrl:album.url ?? StringKey.NA )
                rows.append(rowModel)
            }
        }
        // Set the rowViewModels value
        self.rowViewModels.value = rows
    }
}
