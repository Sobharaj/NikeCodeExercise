//
//  AsyncImage.swift
//  NikeCodeExercise
//
//  Created by Sobharaj on 6/11/20.
//  Copyright © 2020 Home. All rights reserved.
//

import UIKit

import Foundation

/// Promise-pattern wrapped image object, with in-memor eternal cache support
class AsyncImage {
    /// The url for the image resource
    let url: URL?

    /// The downloeded image, it could be a placeholder image if the image is downloading or the download is failed
    var image: UIImage {
        return self.imageStore ?? placeholder
    }

    /// Image download complete closure
    var completeDownload: ((UIImage?) -> Void)?

    private var imageStore: UIImage?
    private var placeholder: UIImage

    private let imageDownloadHelper: ImageDownloadHelperProtocol

    private var isDownloading: Bool = false

    init(url: String,
         placeholderImage: UIImage = #imageLiteral(resourceName: "No_image") ,
         imageDownloadHelper: ImageDownloadHelperProtocol = ImageDownloadHelper()) {
        self.url = URL(string: url)
        self.placeholder = placeholderImage
        self.imageDownloadHelper = imageDownloadHelper
    }

    /// Start download the image with provided url
    func startDownload() {
        if imageStore != nil {
            completeDownload?(image)
        } else {
            if isDownloading { return }
            isDownloading = true
                        
            guard let imageUrl = self.url else { return}
            
            imageDownloadHelper.download(url: imageUrl, completion: { [weak self] (image, response, error) in
                self?.imageStore = image
                self?.isDownloading = false
                DispatchQueue.main.async {
                    self?.completeDownload?(image)
                }
            })
        }
    }
}
