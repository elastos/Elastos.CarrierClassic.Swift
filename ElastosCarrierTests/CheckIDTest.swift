//
//  CheckIDTest.swift
//  ElastosCarrierTests
//
//  Created by 李爱红 on 2019/2/22.
//  Copyright © 2019年 org.elastos. All rights reserved.
//

import XCTest
@testable import ElastosCarrier


class CheckIDTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCheckValidId() {
        let userId: String = "7sRQjDsniyuHdZ9zsQU9DZbMLtQGLBWZ78yHWgjPpTKm"
        XCTAssertTrue(Carrier.isValidUserId(userId))
    }

    func testCheckValidAdress() {
        let adress: String = "VyhDgjkjd5MkPcuwCjGEUCp5jV6HArxSVmBnpXnk7d9h7cQtboMN"
        XCTAssertTrue(Carrier.isValidAddress(adress))
    }
    
    func testCheckInvalidId() {
        let userId: String = "aaaaaasniyuHdZ9zsQU9DZbMLtQGLBWZ78yHWgjPpTKm"
        XCTAssertFalse(Carrier.isValidUserId(userId))
    }
    
    func testInvalidAdress() {
        let adress: String = "aaaaaaakjd5MkPcuwCjGEUCp5jV6HArxSVmBnpXnk7d9h7cQtboMN"
        XCTAssertFalse(Carrier.isValidAddress(adress))
    }
    
    func testGetIdFromAdress() {
        let userId: String = "hYQJcuHHuEXUcUdwio8bN6LktifD7niwaKggvXFga1a"
        let adress: String = "2Y7Evx1pxdBaebzecH1nSiwv4M6UgaNJ8T1BJTLmiYX5S8GRjptF"
        XCTAssertEqual(Carrier.getUserIdFromAddress(adress), userId)
    }
    
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
