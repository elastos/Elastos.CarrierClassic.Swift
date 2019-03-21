//
//  TestHelper.swift
//  ElastosCarrierTests
//
//  Created by 李爱红 on 2019/3/16.
//  Copyright © 2019年 org.elastos. All rights reserved.
//

import UIKit
import XCTest
import ElastosCarrier

public class TestHelper:XCTestCase {
    
    let timeout: Double = 60.0
    static let sharedInstance: TestHelper = { TestHelper() }()
    var lockForCarrier : XCTestExpectation?
    var lockForRobot : XCTestExpectation?
    
    public func addFriendAnyway(_ carrier: Carrier, _ connector: RobotConnector, _ lockForCarrier: XCTestExpectation, _ lockForRobot: XCTestExpectation){
        
        if !(carrier.isFriend(with: connector.robotId!)) {
            do{
                try carrier.addFriend(connector.robotAddress!, withGreeting: "auto-reply")
                wait(for: [lockForCarrier], timeout: timeout)
            }catch {
                print(errno)
            }
        }else {
            let hello = "auto-reply"
            let carrierId = carrier.getUserId()
            let carrierAddress = carrier.getAddress()
            _ = connector.writeCmd("fadd \(carrierId) \(carrierAddress) \(hello)", lockForRobot)
        }
    }
    
    public func removeFriendAnyway(_ carrier: Carrier, _ connector: RobotConnector, _ lockForCarrier: XCTestExpectation, _ lockForRobot: XCTestExpectation){
        self.lockForCarrier = lockForCarrier
        self.lockForRobot = lockForRobot
        
        if carrier.isFriend(with: connector.robotId!) {
            do{
                try carrier.removeFriend(connector.robotId!)
            }catch {
                print(error)
            }
            wait(for: [lockForCarrier], timeout: timeout)
        }
        XCTAssertTrue(connector.writeCmd("fremove \(carrier.getUserId())\n", self.lockForRobot!))
        let robotReadInfo = arraryFromData(connector.readInfo)
        XCTAssertEqual(2, robotReadInfo.count)
        XCTAssertEqual("fremove", robotReadInfo[0])
        XCTAssertEqual("succeeded", robotReadInfo[1])
    }
    
    public func arraryFromData(_ data: Data?) -> Array<String> {
        guard data != nil else {
            return Array()
        }
        let data = data
        var str = String(data: data!, encoding: .utf8)
        str = str?.replacingOccurrences(of: "\n", with: "")
        let robotReadInfo: [String] = (str?.components(separatedBy: " "))!
        return robotReadInfo
    }
    
}
