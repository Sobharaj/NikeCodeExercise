//
//  AlbumListCell.swift
//  NikeCodeExercise
//
//  Created by Sobharaj on 6/11/20.
//  Copyright © 2020 Home. All rights reserved.
//

import UIKit

class AlbumListCell: UITableViewCell {
    
    /// viewModel is the refrence of AlbumCellViewModel
    var viewModel : AlbumCellViewModel?
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    /// containerView is the refrence of UIView
    let containerView:UIView = {return customView()}()
    
    /// albumNameLabel is  the refrence of UILabel for displaying Album Name
    let albumNameLabel:UILabel = {return customLabel(appBoldFont(size: 18))}()
   
    /// artistNameLabel is  the refrence of UILabel for displaying Artist name
    let artistNameLabel:UILabel = {
        let label = customLabel(appBoldFont(size: 14))
        label.textColor = #colorLiteral(red: 1, green: 0.1857388616, blue: 0.5733950138, alpha: 0.408791738)
        return label}()
    
    /// thumbnailImageView is  the refrence of UIImageView for Album photo
    let thumbnailImageView:UIImageView = {
        let iamgeView = customImageView()
        iamgeView.layer.cornerRadius = 35
        return iamgeView
    }()
    
    //MARK: - View Life Cycle Method

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setLauoutConstraint()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        // Release the memory of viewModel?.image.completeDownload
        viewModel?.image.completeDownload = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    //MARK: - General Method

    /// This method is responsbile for  adding the Layouts and Constraint
    func setLauoutConstraint() {

        //Adding thumbnailImageView in Self.contentView
        self.contentView.addSubview(thumbnailImageView)
        // Setting the constraint of thumbnailImageView
        NSLayoutConstraint.activate([
            thumbnailImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor),
            thumbnailImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10),
            thumbnailImageView.widthAnchor.constraint(equalToConstant:70),
            thumbnailImageView.heightAnchor.constraint(equalToConstant:70)])
        
        //Adding containerView in Self.contentView
        self.contentView.addSubview(containerView)
        // Setting the constraint of containerView
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor),
            containerView.leadingAnchor.constraint(equalTo:self.thumbnailImageView.trailingAnchor, constant:10),
            containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10),
            containerView.heightAnchor.constraint(equalToConstant:55)])
        
        //Adding albumNameLabel in containerView
        containerView.addSubview(albumNameLabel)
        // Setting the constraint of albumNameLabel
        NSLayoutConstraint.activate([
            albumNameLabel.topAnchor.constraint(equalTo:self.containerView.topAnchor),
            albumNameLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor),
            albumNameLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor),
            albumNameLabel.heightAnchor.constraint(equalToConstant: 25)])
      
        //Adding artistNameLabel in containerView
        containerView.addSubview(artistNameLabel)
        // Setting the constraint of artistNameLabel
        NSLayoutConstraint.activate([
            artistNameLabel.topAnchor.constraint(equalTo:self.albumNameLabel.bottomAnchor, constant: 5),
            artistNameLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor),
            artistNameLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor),
            artistNameLabel.heightAnchor.constraint(equalToConstant: 25)])
    }
    
    
    /// This method is responsible for load the data in UItableViewCell
    ///
    /// - Parameters:
    ///   - viewModel: reference of AlbumCellViewModel
    func loadData(viewModel: AlbumCellViewModel) {
        // Set the AlbumCellViewModel reference  to global viewModel
        self.viewModel = viewModel
        
        // Set the text to albumNameLabel
        self.albumNameLabel.text = self.viewModel?.albumName
        
        // Set the text to artistNameLabel
        self.artistNameLabel.text = " \(self.viewModel?.artistName ?? StringKey.EMPTYSTRING)"
        
        // Set the image to thumbnailImageView
        self.thumbnailImageView.image = self.viewModel?.image.image
        
        // Start downloading the image
        self.viewModel?.image.startDownload()
        
        // Once download of image completed , set to the thumbnailImageView
        self.viewModel?.image.completeDownload = { [weak self] image in
            self?.thumbnailImageView.image = image
        }
        
        setNeedsLayout()
    }
    
        
}
