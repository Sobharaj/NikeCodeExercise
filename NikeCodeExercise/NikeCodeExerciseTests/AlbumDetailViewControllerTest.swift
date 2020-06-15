//
//  AlbumDetailViewControllerTest.swift
//  NikeCodeExerciseTests
//
//  Created by Sobharaj on 6/14/20.
//  Copyright © 2020 Home. All rights reserved.
//

import XCTest
@testable import NikeCodeExercise

class AlbumDetailViewControllerTest: XCTestCase {
    
    /// detailViewController is the refrence of AlbumDetailViewController Controller
    var detailViewController : AlbumDetailViewController?
    
    /// mockAlbumCellViewModel is the refrence of AlbumCellViewModel class
    let mockAlbumCellViewModel = AlbumCellViewModel(albumName: "Shape & Destroy", artistName: "Ruston Kelly", image: AsyncImage(url:"https://is4-ssl.mzstatic.com/image/thumb/Music113/v4/f2/5e/7c/f25e7cd1-aac9-2f16-e835-0f4124096ffd/20CRGIM20766.rgb.jpg/200x200bb.png"), releaseDate: "2020-07-17", copyRight: "℗ 2020 Rounder Records., Distributed by Concord.", genre: "Singer/Songwriter", albumUrl: "https://music.apple.com/us/album/shape-destroy/1514477867?app=music")
    
    override func setUp() {
        // Prepare the AlbumDetailViewController.Dependencies reference
        let dependencies =   AlbumDetailViewController.Dependencies(albumViewModel: mockAlbumCellViewModel)
       
        // Prepare the AlbumDetailViewController reference
        detailViewController = AlbumDetailViewController(dependencies:dependencies)
        
        detailViewController?.loadView()
        detailViewController?.viewDidLoad()
    }
    
    // This method is reponsible for testing the AlbumDetailViewController with proper data
    func testAlbumDetail(){
        detailViewController?.viewDidLoad()

        // Test the detailViewController?.title text
        XCTAssertTrue(detailViewController?.title == StringKey.ALBUMDETAIL_PAGETITLE)

        // Test the albumNameValueLabel text
        XCTAssertTrue(detailViewController?.albumDetailView.albumNameValueLabel.text == mockAlbumCellViewModel.albumName)
       
        // Test the artistNameValueLabel text
        XCTAssertTrue(detailViewController?.albumDetailView.artistNameValueLabel.text == mockAlbumCellViewModel.artistName)
        
        // Test the genreValueLabel text
        XCTAssertTrue(detailViewController?.albumDetailView.genreValueLabel.text == mockAlbumCellViewModel.genre)
       
        // Test the releaseDateValueLabel text
        XCTAssertTrue(detailViewController?.albumDetailView.releaseDateValueLabel.text == mockAlbumCellViewModel.releaseDate)
        
        // Test the copyRightValueLabel text
        XCTAssertTrue(detailViewController?.albumDetailView.copyRightValueLabel.text == mockAlbumCellViewModel.copyRight)
    }
    
    override func tearDown() {
        detailViewController = nil
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
