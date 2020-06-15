//
//  MockAlbumService.swift
//  NikeCodeExercise
//
//  Created by Sobharaj on 6/13/20.
//  Copyright © 2020 Home. All rights reserved.
//

import UIKit

// This class is the Mock of AlbumService Class
final class MockAlbumService: AlbumService, Mockable {

    // Create the refrence of mockfetchMusicFeed
    var mockfetchMusicFeed = Mock()
    
    // Create the refrence of mockAlbumModel
    var mockAlbumModel = Mock()
    

    override func fetchMusicFeed(completion: @escaping (_ data: AlbumModel?, _ error: Error?) -> Void) {
        perform(mockfetchMusicFeed, parameters: (completion))
    }

}
