//
//  AlbumService.swift
//  NikeCodeExercise
//
//  Created by Sobharaj on 6/11/20.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation

class AlbumService {
    
    /// This method is responsible for calling the Feed service and getting the response
    ///
    /// - Parameters:
    ///   - (_ data: AlbumModel?, _ error: Error?):
    func fetchMusicFeed(completion: @escaping (_ data: AlbumModel?, _ error: Error?) -> Void) {
        HTTPManager.shared.get(urlString: "https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/100/explicit.json", completionBlock: { result in
            switch result {
            case .failure(let error):
                print ("failure", error)
                completion(nil, error)

            case .success(let dta) :
                let decoder = JSONDecoder()
                do
                {
                  let feed = try decoder.decode(AlbumModel.self, from: dta)
                    completion(feed, nil)
                } catch let er as NSError{
                    completion(nil, er)
                }
            }
        })
    }
}
