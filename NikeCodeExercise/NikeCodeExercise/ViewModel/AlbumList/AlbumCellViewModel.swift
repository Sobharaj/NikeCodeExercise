//
//  AlbumCellViewModel.swift
//  NikeCodeExercise
//
//  Created by Sobharaj on 6/11/20.
//  Copyright © 2020 Home. All rights reserved.
//

import UIKit

class AlbumCellViewModel {

    let albumName: String
    let artistName: String
    let releaseDate: String
    let copyRight: String
    let genre: String
    let albumUrl: String
    var image: AsyncImage


    // This method is responsible for initializing the AlbumCellViewModel
    init(albumName: String, artistName: String, image: AsyncImage,releaseDate: String,copyRight: String,genre: String, albumUrl: String) {
        self.albumName = albumName
        self.artistName = artistName
        self.image = image
        self.releaseDate = releaseDate
        self.copyRight = copyRight
        self.genre = genre
        self.albumUrl = albumUrl

    }
}
