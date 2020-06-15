//
//  AlbumDetailView.swift
//  NikeCodeExercise
//
//  Created by Sobharaj on 6/13/20.
//  Copyright © 2020 Home. All rights reserved.
//

import UIKit


// Creating prorocol for AlbumDetailViewDelegate
protocol AlbumDetailViewDelegate: AnyObject {
    func openAlbumInItune()
}

class AlbumDetailView: UIView {
    
    //delegate is the refernce of AlbumDetailViewDelegate
   weak var delegate :AlbumDetailViewDelegate?
    
    // artWorkImageView is the refrence of UIImageView
    let artWorkImageView:UIImageView = {return customImageView()}()
    
    // topView is the refrence of UIView
    let topView:UIView = {return customView()}()
    
    // bottomView is the refrence of UIView
    let bottomView:UIView = {return customView()}()
    
    // cointainerView is the refrence of UIView
    let cointainerView:UIView = {return customView()}()
    
    // albumButton is the refrence of UIButton
    let albumButton:UIButton = {
        let button = customButton()
        button.setTitle(StringKey.ALBUMDETAIL_OPENINITUNE, for: .normal)
        button.addTarget(self, action: #selector(albumButtonClicked), for: .touchUpInside)
        return button
    }()
    
    // albumNameLabel is the refrence of UILable
    let albumNameLabel:UILabel = {
        let label = customLabel(appBoldFont(size: 14))
        label.text = StringKey.ALBUMDETAIL_NAMELABEL
        return label }()
    
    // albumNameValueLabel is the refrence of UILable
    let albumNameValueLabel:UILabel = {return customLabel(appFont(size: 16))}()
    
    // artistNameLabel is the refrence of UILable
    let artistNameLabel:UILabel = {
        let label = customLabel(appBoldFont(size: 14))
        label.text = StringKey.ALBUMDETAIL_ARTISTNAME
        return label }()
    
    // artistNameValueLabel is the refrence of UILable
    let artistNameValueLabel:UILabel = {return customLabel(appFont(size: 16))}()
    
    // releaseDateLabel is the refrence of UILable
    let releaseDateLabel:UILabel = {
        let label = customLabel(appBoldFont(size: 14))
        label.text = StringKey.ALBUMDETAIL_RELEASEDATE
        return label }()
    
    // releaseDateValueLabel is the refrence of UILable
    let releaseDateValueLabel:UILabel = {return customLabel(appFont(size: 16))}()
    
    // copyRightLabel is the refrence of UILable
    let copyRightLabel:UILabel = {
        let label = customLabel(appBoldFont(size: 14))
        label.text = StringKey.ALBUMDETAIL_COPYRIGHT
        return label }()
    
    // copyRightValueLabel is the refrence of UILable
    let copyRightValueLabel:UILabel = {return customLabel(appFont(size: 16))}()
    
    // genreLabel is the refrence of UILable
    let genreLabel:UILabel = {
        let label = customLabel(appBoldFont(size: 14))
        label.text = StringKey.ALBUMDETAIL_GENRE
        return label }()
    
    // genreValueLabel is the refrence of UILable
    let genreValueLabel:UILabel = {return customLabel(appFont(size: 16))}()
    
    // scrollView is the refrence of UIScrollView
    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    //MARK: - View Life Cycle Method
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        // This method call to add the Layouts and Constraint
        self.setupUILauoutConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError(StringKey.INIT_FATAL_ERROR)
    }
    
    deinit {
        print("AlbumDetailView--Deinit")
    }

    //MARK: - General Method
    
    /// This method is responsbile for  adding the Layouts and Constraint
    func setupUILauoutConstraint()  {

        //Adding topView in Self.View
        self.addSubview(topView)
        // Setting the constraint of topView
        NSLayoutConstraint.activate([
            topView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            topView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            topView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -90)])

        //Adding bottomView in Self.View
        self.addSubview(bottomView)
        // Setting the constraint of bottomView
        NSLayoutConstraint.activate([
            bottomView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            bottomView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)])

        
        //Adding artWorkImageView in topView
        topView.addSubview(artWorkImageView)
        // Setting the constraint of artWorkImageView
        NSLayoutConstraint.activate([
            artWorkImageView.leadingAnchor.constraint(equalTo:topView.leadingAnchor),
            artWorkImageView.trailingAnchor.constraint(equalTo:topView.trailingAnchor),
            artWorkImageView.topAnchor.constraint(equalTo:topView.topAnchor),
            artWorkImageView.heightAnchor.constraint(equalToConstant: 400)])
        
        //Adding scrollView in topView
        topView.addSubview(scrollView)
        // Setting the constraint of scrollView
        NSLayoutConstraint.activate([
            scrollView.leftAnchor.constraint(equalTo: topView.leftAnchor),
            scrollView.topAnchor.constraint(equalTo: artWorkImageView.bottomAnchor),
            scrollView.bottomAnchor.constraint(equalTo: topView.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: topView.widthAnchor)])
        
        //Adding cointainerView in scrollView
        scrollView.addSubview(cointainerView)
        // Setting the constraint of cointainerView
        NSLayoutConstraint.activate([
            cointainerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            cointainerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            cointainerView.trailingAnchor.constraint(equalTo: topView.trailingAnchor),
            cointainerView.bottomAnchor.constraint(equalTo:scrollView.bottomAnchor)])
        
        //Adding albumNameLabel in cointainerView
        cointainerView.addSubview(albumNameLabel)
        // Setting the constraint of albumNameLabel
        NSLayoutConstraint.activate([
            albumNameLabel.leadingAnchor.constraint(equalTo: cointainerView.leadingAnchor, constant: 10.0),
            albumNameLabel.topAnchor.constraint(equalTo: cointainerView.topAnchor, constant: 10.0),
            albumNameLabel.widthAnchor.constraint(equalToConstant: 50),
            albumNameLabel.heightAnchor.constraint(equalToConstant: 20)])

        
        //Adding albumNameValueLabel in cointainerView
        cointainerView.addSubview(albumNameValueLabel)
        // Setting the constraint of albumNameValueLabel
        NSLayoutConstraint.activate([
            albumNameValueLabel.topAnchor.constraint(equalTo: cointainerView.topAnchor, constant: 10),
            albumNameValueLabel.leadingAnchor.constraint(equalTo: albumNameLabel.trailingAnchor, constant: 5),
            albumNameValueLabel.trailingAnchor.constraint(equalTo: cointainerView.trailingAnchor, constant: -10)])
        
        
        //Adding artistNameLabel in cointainerView
        cointainerView.addSubview(artistNameLabel)
        // Setting the constraint of artistNameLabel
        NSLayoutConstraint.activate([
            artistNameLabel.leadingAnchor.constraint(equalTo: cointainerView.leadingAnchor, constant: 10.0),
            artistNameLabel.topAnchor.constraint(equalTo: albumNameValueLabel.bottomAnchor, constant: 10.0),
            artistNameLabel.widthAnchor.constraint(equalToConstant: 90),
            artistNameLabel.heightAnchor.constraint(equalToConstant: 20)])

        //Adding artistNameValueLabel in cointainerView
        cointainerView.addSubview(artistNameValueLabel)
         // Setting the constraint of artistNameValueLabel
        NSLayoutConstraint.activate([
            artistNameValueLabel.topAnchor.constraint(equalTo: albumNameValueLabel.bottomAnchor, constant: 10),
            artistNameValueLabel.leadingAnchor.constraint(equalTo: artistNameLabel.trailingAnchor, constant: 5),
            artistNameValueLabel.trailingAnchor.constraint(equalTo: cointainerView.trailingAnchor, constant: -10)])
        
        //Adding genreLabel in cointainerView
        cointainerView.addSubview(genreLabel)
        // Setting the constraint of genreLabel
        NSLayoutConstraint.activate([
            genreLabel.leadingAnchor.constraint(equalTo: cointainerView.leadingAnchor, constant: 10.0),
            genreLabel.topAnchor.constraint(equalTo: artistNameValueLabel.bottomAnchor, constant: 10.0),
            genreLabel.widthAnchor.constraint(equalToConstant: 55),
            genreLabel.heightAnchor.constraint(equalToConstant: 20)])

        //Adding genreValueLabel in cointainerView
        cointainerView.addSubview(genreValueLabel)
        // Setting the constraint of genreValueLabel
        NSLayoutConstraint.activate([
            genreValueLabel.topAnchor.constraint(equalTo: artistNameValueLabel.bottomAnchor, constant: 10),
            genreValueLabel.leadingAnchor.constraint(equalTo: genreLabel.trailingAnchor, constant: 5),
            genreValueLabel.trailingAnchor.constraint(equalTo: cointainerView.trailingAnchor, constant: -10)])
        
        //Adding releaseDateLabel in cointainerView
        cointainerView.addSubview(releaseDateLabel)
        // Setting the constraint of releaseDateLabel
        NSLayoutConstraint.activate([
            releaseDateLabel.leadingAnchor.constraint(equalTo: cointainerView.leadingAnchor, constant: 10.0),
            releaseDateLabel.topAnchor.constraint(equalTo: genreValueLabel.bottomAnchor, constant: 10.0),
            releaseDateLabel.widthAnchor.constraint(equalToConstant: 100),
            releaseDateLabel.heightAnchor.constraint(equalToConstant: 20)])

        //Adding releaseDateValueLabel in cointainerView
        cointainerView.addSubview(releaseDateValueLabel)
        // Setting the constraint of releaseDateValueLabel
        NSLayoutConstraint.activate([
            releaseDateValueLabel.topAnchor.constraint(equalTo: genreValueLabel.bottomAnchor, constant: 10),
            releaseDateValueLabel.leadingAnchor.constraint(equalTo: releaseDateLabel.trailingAnchor, constant: 5),
            releaseDateValueLabel.trailingAnchor.constraint(equalTo: cointainerView.trailingAnchor, constant: -10)])
        
        //Adding copyRightLabel in cointainerView
        cointainerView.addSubview(copyRightLabel)
        // Setting the constraint of copyRightLabel
        NSLayoutConstraint.activate([
            copyRightLabel.leadingAnchor.constraint(equalTo: cointainerView.leadingAnchor, constant: 10.0),
            copyRightLabel.topAnchor.constraint(equalTo: releaseDateValueLabel.bottomAnchor, constant: 10.0),
            copyRightLabel.widthAnchor.constraint(equalToConstant: 85),
            copyRightLabel.heightAnchor.constraint(equalToConstant: 20)])

        //Adding copyRightValueLabel in cointainerView
        cointainerView.addSubview(copyRightValueLabel)
        // Setting the constraint of copyRightValueLabel
        NSLayoutConstraint.activate([
            copyRightValueLabel.topAnchor.constraint(equalTo: releaseDateValueLabel.bottomAnchor, constant: 10),
            copyRightValueLabel.leadingAnchor.constraint(equalTo: copyRightLabel.trailingAnchor, constant: 5),
            copyRightValueLabel.trailingAnchor.constraint(equalTo: cointainerView.trailingAnchor, constant: -10),
            copyRightValueLabel.bottomAnchor.constraint(equalTo:cointainerView.bottomAnchor, constant: -10)])
        
        //Adding albumButton in bottomView
        bottomView.addSubview(albumButton)
        // Setting the constraint of albumButton
        NSLayoutConstraint.activate([
            albumButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 20),
            albumButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -20),
            albumButton.heightAnchor.constraint(equalToConstant: 50),
            albumButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -20)])
    }
    
    //MARK: - Button Action Method

    @objc  func albumButtonClicked()  {
        guard let delagte = self.delegate  else {
            return
        }
        delagte.openAlbumInItune()
    }


}
