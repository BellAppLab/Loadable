//
//  ExampleTests.swift
//  ExampleTests
//
//  Created by André Campana on 09.10.17.
//  Copyright © 2017 Bell App Lab. All rights reserved.
//

import XCTest
@testable import Example


class NotificationObject: NSObject, UILoader
{
    static let deinitNotification = NSNotification.Name(rawValue: "DidDeinit")
    static let loadingStatusNotification = NSNotification.Name(rawValue: "DidChangeStatus")
    static let loadingStatusUserInfoKey = "NewLoadingStatus"
    
    deinit {
        NotificationCenter.default.post(name: NotificationObject.deinitNotification,
                                        object: nil)
    }
    
    func didChangeLoadingStatus(_ loading: Bool) {
        NotificationCenter.default.post(name: NotificationObject.loadingStatusNotification,
                                        object: nil,
                                        userInfo: [NotificationObject.loadingStatusUserInfoKey: loading])
    }
}


class ExampleTests: XCTestCase
{
    func testDeinit() {
        var obj: NotificationObject? = NotificationObject()
        
        let expectDeinit = expectation(forNotification: NotificationObject.deinitNotification, object: nil) { (notification) -> Bool in
            return true
        }
        
        obj?.isLoading = true
        obj?.isLoading = false
        obj = nil
        
        wait(for: [expectDeinit],
             timeout: 10)
    }
    
    func testLoadingStatus() {
        let vc = ViewController()
        
        vc.isLoading = true
        XCTAssertTrue(vc.isLoading, "The ViewController's loading property should be true")
    }
    
    func testFiveTimes() {
        let vc = ViewController()
        
        vc.isLoading = true
        XCTAssertTrue(vc.isLoading, "The ViewController's loading property should be true for the first time")
        
        vc.isLoading = true
        XCTAssertTrue(vc.isLoading, "The ViewController's loading property should be true for the second time")
        
        vc.isLoading = true
        XCTAssertTrue(vc.isLoading, "The ViewController's loading property should be true for the third time")
        
        vc.isLoading = true
        XCTAssertTrue(vc.isLoading, "The ViewController's loading property should be true for the fourth time")
        
        vc.isLoading = true
        XCTAssertTrue(vc.isLoading, "The ViewController's loading property should be true for the fifth time")
        
        vc.isLoading = false
        XCTAssertTrue(vc.isLoading, "The ViewController's loading property should be true for the first decrement")
        
        vc.isLoading = false
        XCTAssertTrue(vc.isLoading, "The ViewController's loading property should be true for the second decrement")
        
        vc.isLoading = false
        XCTAssertTrue(vc.isLoading, "The ViewController's loading property should be true for the third decrement")
        
        vc.isLoading = false
        XCTAssertTrue(vc.isLoading, "The ViewController's loading property should be true for the fourth decrement")
        
        vc.isLoading = false
        XCTAssertFalse(vc.isLoading, "The ViewController's loading property should be false for the fifth decrement")
    }
    
    func testLoadingStatusChange() {
        let obj = NotificationObject()
        
        let expectLoadingStatusChange = expectation(forNotification: NotificationObject.loadingStatusNotification, object: nil) { (notification) -> Bool in
            return notification.userInfo?[NotificationObject.loadingStatusUserInfoKey] as? Bool == obj.isLoading
        }
        
        obj.isLoading = true
        
        wait(for: [expectLoadingStatusChange],
             timeout: 10)
    }
}
