//
//  AlbumListViewControllerTest.swift
//  NikeCodeExerciseTests
//
//  Created by Sobharaj on 6/14/20.
//  Copyright © 2020 Home. All rights reserved.
//

import XCTest
@testable import NikeCodeExercise

class AlbumListViewControllerTest: XCTestCase {
    
    /// albumListViewController is the refrence of AlbumListViewController Controller
    var albumListViewController : AlbumListViewController?
    
    
    /// albumService is the refrence of MockAlbumService class
    var albumService: MockAlbumService = MockAlbumService()
    
    /// mockAlbumModel is the refrence of Mock class
    var mockAlbumModel = Mock()
    
    /// albumModelWithOneFeed is the refrence of AlbumModel class
    let albumModelWithOneFeed = AlbumModel(feed: AlbumModel.Feed(title: "", id: "", author: nil, links: [], copyright: "", country: "", icon: "", updated: "", results: [AlbumModel.Result(artistName: StringKey.NA, id: "", releaseDate: "", name: StringKey.NA, kind: nil, copyright: "", artistID: "", contentAdvisoryRating: "", artistURL: "", artworkUrl100: "", genres: nil, url: "")]))
    
    /// albumModelWithOneFeed is the refrence of AlbumModel class
    let albumModelWithNilObject = AlbumModel(feed: AlbumModel.Feed(title: "", id: "", author: nil, links: [], copyright: "", country: "", icon: "", updated: "", results: [AlbumModel.Result(artistName: nil, id: "", releaseDate: nil, name: nil, kind: nil, copyright: nil, artistID: "", contentAdvisoryRating: "", artistURL: "", artworkUrl100: nil, genres: [AlbumModel.Genre(genreID: nil, name: nil, url: nil)], url: nil)]))
    
    
    override func setUp() {
        // Create the mock outcome of albumService
        albumService.mockfetchMusicFeed.mockOutcome(()) { params in
            guard let (completion) = params as? ( (_ data: AlbumModel?, _ error: Error?) -> Void) else {
                XCTFail(StringKey.INCORRECT_CASTING)
                return}
            completion(self.albumModelWithOneFeed, nil)}
        // Create the AlbumListViewModel refrence
        let viewModel: AlbumListViewModel = AlbumListViewModel(dependencies: AlbumListViewModel.Dependencies(albumService: albumService))
        
        // Create the AlbumListViewController refrence
        albumListViewController = AlbumListViewController(dependencies: AlbumListViewController.Dependencies(viewModel: viewModel))
        
        albumListViewController?.loadView()
    }
    
    override func tearDown() {
        albumListViewController = nil
    }
        
    /// This method is responsible for test the AlbumListViewController with One Album feed response
    func testAlbumListWithOneAlbumFeed() {
        
        albumService.mockfetchMusicFeed.mockOutcome(()) { params in
            guard let (completion) = params as? ( (_ data: AlbumModel?, _ error: Error?) -> Void) else {
                XCTFail(StringKey.INCORRECT_CASTING)
                return}
            completion(self.albumModelWithOneFeed, nil)}
        
        let viewModel: AlbumListViewModel = AlbumListViewModel(dependencies: AlbumListViewModel.Dependencies(albumService: albumService))
        
        albumListViewController?.dependencies = AlbumListViewController.Dependencies(viewModel: viewModel)
        albumListViewController?.startLoadingFeedData()
        sleep(2)
        XCTAssertTrue(albumListViewController?.tblViewAlbum.isHidden == false)
        XCTAssertTrue(albumListViewController?.dependencies.viewModel?.rowViewModels.value.count == 1)
        XCTAssertTrue(albumListViewController?.loadingIndicator.isAnimating == false)
        
    }
    
    /// This method is responsible for test the AlbumListViewController with One Album feed with Nill Object response
    func testAlbumListWithOneAlbumFeedWitNilObject() {
        albumService.mockfetchMusicFeed.mockOutcome(()) { params in
            guard let (completion) = params as? ( (_ data: AlbumModel?, _ error: Error?) -> Void) else {
                XCTFail(StringKey.INCORRECT_CASTING)
                return
            }
            completion(self.albumModelWithNilObject, nil)
        }
        
        let viewModel: AlbumListViewModel = AlbumListViewModel(dependencies: AlbumListViewModel.Dependencies(albumService: albumService))
        
        albumListViewController?.dependencies = AlbumListViewController.Dependencies(viewModel: viewModel)
        albumListViewController?.startLoadingFeedData()
        sleep(2)
        XCTAssertTrue(albumListViewController?.tblViewAlbum.isHidden == false)
        XCTAssertTrue(albumListViewController?.dependencies.viewModel?.rowViewModels.value.count == 1)
        XCTAssertTrue(albumListViewController?.loadingIndicator.isAnimating == false)
        
    }
    
    /// This method is responsible for test the AlbumListViewController with error response
    func testAlbumListWithError() {
        albumService.mockfetchMusicFeed.mockOutcome(()) { params in
            guard let (completion) = params as? ( (_ data: AlbumModel?, _ error: Error?) -> Void) else {
                XCTFail(StringKey.INCORRECT_CASTING)
                return
            }
            completion(nil,NSError(domain: StringKey.ERROR_TEST, code: 0, userInfo: [StringKey.ERROR : StringKey.ERROR_TEST]))
        }
        
        let viewModel: AlbumListViewModel = AlbumListViewModel(dependencies: AlbumListViewModel.Dependencies(albumService: albumService))
        
        albumListViewController?.dependencies = AlbumListViewController.Dependencies(viewModel: viewModel)
        albumListViewController?.startLoadingFeedData()
        sleep(2)
        XCTAssertTrue(albumListViewController?.dependencies.viewModel?.rowViewModels.value.count == 0)
        XCTAssertTrue(albumListViewController?.loadingIndicator.isAnimating == false)
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
