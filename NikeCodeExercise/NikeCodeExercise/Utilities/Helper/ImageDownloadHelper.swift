//
//  ImageDownloadHelper.swift
//  NikeCodeExercise
//
//  Created by Sobharaj on 6/11/20.
//  Copyright © 2020 Home. All rights reserved.
//

import UIKit
import Foundation

// Creating prorocol for ImageDownloadHelperProtocol
protocol ImageDownloadHelperProtocol {
    func download(url: URL, completion: @escaping (UIImage?, URLResponse?, Error?) -> ())
}

class ImageDownloadHelper: ImageDownloadHelperProtocol {
    let urlSession: URLSession = URLSession.shared

    static var shared: ImageDownloadHelper = {
        return ImageDownloadHelper()
    }()

    func download(url: URL, completion: @escaping (UIImage?, URLResponse?, Error?) -> ()) {
        urlSession.dataTask(with: url) { data, response, error in
            if let data = data {
                completion(UIImage(data: data), response, error)
            } else {
                completion(nil, response, error)
            }
        }.resume()
    }
}

