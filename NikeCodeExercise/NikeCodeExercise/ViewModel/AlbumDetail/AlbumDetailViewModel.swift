//
//  AlbumDetailViewModel.swift
//  NikeCodeExercise
//
//  Created by Sobharaj on 6/13/20.
//  Copyright © 2020 Home. All rights reserved.
//

import UIKit

class AlbumDetailViewModel {
    // Creating Observable rowViewModels reference
    let rowViewModels = Observable<AlbumCellViewModel?>(value: nil)
    
    /// This method is responsible for loading album data
    ///
    /// - Parameters:
    ///   - album: reference of AlbumCellViewModel
    func loadAlbumData(with  album: AlbumCellViewModel?) {
        rowViewModels.value = album
    }
    
    deinit {
        print("AlbumDetailViewModel--Deinit")
    }

}
