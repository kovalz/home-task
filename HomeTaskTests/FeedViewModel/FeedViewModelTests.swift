//
//  FeedViewModelTests+Items.swift
//  HomeTaskTests
//
//  Created by Zhenya Koval on 2/3/18.
//  Copyright © 2018 Zhenya Koval. All rights reserved.
//

import XCTest

class FeedViewModelTests: XCTestCase {
    
    private enum FakeError: Error {
        case unknown
    }
    
    private var linksDataSource: FakeLinksDataSource!
    private var userNotificationCenter: FakeUserNotificationCenter!
    private var feedViewModel: FeedViewModel!

    override func setUp() {
        super.setUp()

        linksDataSource = FakeLinksDataSource()
        userNotificationCenter = FakeUserNotificationCenter()
        feedViewModel = FeedViewModel(dataSource: linksDataSource, userNotificationCenter: userNotificationCenter)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Paging -
    
    // MARK: Initial Loading
    
    func testInitialLoadingWithCorrectPaging() {
        feedViewModel.reloadItems()
        XCTAssertNil(linksDataSource.paging!.after, "`reloadItems` should set `after` = nil.")
    }
    
    func testInitialLoadingCreatesFeedItems() {
        let result = FakeLinks.createSingleLinkList(title: "initial")
        
        feedViewModel.reloadItems()
        linksDataSource.success!(result)
        
        XCTAssertEqual(feedViewModel.items.value.count, 1, "`reloadItems` should create `feedItems`.")
        XCTAssertEqual(feedViewModel.items.value[0].title, "initial", "`reloadItems` should create `feedItems`.")
    }
    
    func testInitialLoadingFailureSendsNotification() {
        feedViewModel.reloadItems()
        linksDataSource.failure!(FakeError.unknown)
        
        XCTAssertTrue(userNotificationCenter.didNotifyAboutError, "User should be notified about `reloadItems` failure.")
    }
    
    // MARK: Load More
    
    func testLoadMoreItemsWithCorrectPaging() {
        feedViewModel.reloadItems()
        let result = FakeLinks.createSingleLinkList(after: "123")
        linksDataSource.success!(result)
        
        feedViewModel.loadMoreItems()
        XCTAssertEqual(linksDataSource.paging!.after, "123", "`reloadItems` should set correct `after`.")
    }
    
    func testLoadMoreAppendsFeedItems() {
        let intialResult = FakeLinks.createSingleLinkList(title: "initial")
        feedViewModel.reloadItems()
        linksDataSource.success!(intialResult)
        
        let loadMoreResult = FakeLinks.createSingleLinkList(title: "new")
        feedViewModel.loadMoreItems()
        linksDataSource.success!(loadMoreResult)
        
        XCTAssertEqual(feedViewModel.items.value.count, 2, "`loadMore` should append `feedItems`")
        XCTAssertEqual(feedViewModel.items.value[0].title, "initial", "`loadMore` should keep initial `feedItems`")
        XCTAssertEqual(feedViewModel.items.value[1].title, "new", "`loadMore` should append `feedItems`")
    }
    
    func testLoadMoreFailureDoesNotSendNotification() {
        feedViewModel.loadMoreItems()
        linksDataSource.failure?(FakeError.unknown)
        
        XCTAssertFalse(userNotificationCenter.didNotifyAboutError, "User should not be notified about `loadMoreItems` failure.")
    }
    
    // MARK: Reload

    func testReloadItemsResetsPaging() {
        feedViewModel.reloadItems()
        let result = FakeLinks.createSingleLinkList(after: "123")
        linksDataSource.success!(result)
        
        feedViewModel.loadMoreItems()
        XCTAssertEqual(linksDataSource.paging!.after, "123", "`loadMoreItems` should set correct `after`")

        feedViewModel.reloadItems()
        XCTAssertNil(linksDataSource.paging!.after, "`reloadItems` should set `after` = nil")
    }
 
    func testReloadRemovesOldFeedItems() {
        let intialResult = FakeLinks.createSingleLinkList(title: "old")
        feedViewModel.reloadItems()
        linksDataSource.success!(intialResult)
        
        XCTAssertEqual(feedViewModel.items.value.count, 1)

        let reloadResult = FakeLinks.createSingleLinkList(title: "new")
        feedViewModel.reloadItems()
        linksDataSource.success!(reloadResult)
        
        XCTAssertEqual(feedViewModel.items.value.count, 1)
        XCTAssertEqual(feedViewModel.items.value[0].title, "new", "`feedItems` should contain only new item afrer `reloadItems`")
    }
    
}
