//
//  FriendAddTest.swift
//  ElastosCarrierTests
//
//  Created by 李爱红 on 2019/3/14.
//  Copyright © 2019年 org.elastos. All rights reserved.
//

import XCTest
@testable import ElastosCarrier

public struct TestContext {
    public var robotOnline: Bool = false
    public var robotConnectionStatus: CarrierConnectionStatus = CarrierConnectionStatus.Disconnected
    public var from: String = ""
    public var hello: String = ""
    public var userInfo: CarrierUserInfo?
}

class AddFriendTest: XCTestCase, CarrierDelegate{
    
    let robot = RobotConnector.sharedInstance
    let helper = TestHelper.sharedInstance
    var context = TestContext()
    var lockForCarrier: XCTestExpectation?
    var lockForRobot: XCTestExpectation?
    let timeout: Double = 600.0
    var carrier: Carrier? = nil
    
    
    func didBecomeReady(_ carrier: Carrier) {
        lockForCarrier!.fulfill()
    }
    
    func friendRemoved(_ carrier: Carrier, _ friendId: String) {
        lockForCarrier!.fulfill()
    }
    
    func newFriendAdded(_ carrier: Carrier, _ newFriend: CarrierFriendInfo) {
        lockForCarrier!.fulfill()
    }
    
    func didReceiveFriendRequest(_ carrier: Carrier, _ userId: String, _ userInfo: CarrierUserInfo, _ hello: String) {
        context.from = userId
        context.userInfo = userInfo
        context.hello = hello
        lockForCarrier?.fulfill()
    }
    
    func friendConnectionDidChange(_ carrier: Carrier, _ friendId: String, _ newStatus: CarrierConnectionStatus) {
        context.from = friendId
        context.robotConnectionStatus = newStatus
        if context.robotConnectionStatus.rawValue == 0 {
            context.robotOnline = true
        }
        lockForCarrier?.fulfill()
    }
    
    override func setUp() {
        super.setUp()
        lockForRobot = XCTestExpectation(description: "wait for robot ready")
        _ = robot.connectToRobot(lockForRobot!)
        if robot.isConnected {
            print("robot is online, start test")
        }
        let options = TestOptions.options()
        do {
            try Carrier.initializeSharedInstance(options: options, delegate: self)
            carrier = Carrier.sharedInstance()
            try carrier?.start()
            lockForCarrier = XCTestExpectation(description: "wait for carrier ready")
            wait(for: [lockForCarrier!], timeout: timeout)
            print("Carrier node is ready now")
        } catch {
            print("Carrier node start failed, abort this test.")
        }
    }
    
    func testAddfriend() {
        lockForCarrier = XCTestExpectation(description: "wait for carrier remove robot")
        lockForRobot = XCTestExpectation(description: "wait for robot remove carrier")
        helper.removeFriendAnyway(carrier!, robot, lockForCarrier!, lockForRobot!)
        XCTAssertFalse((carrier?.isFriend(with: robot.robotId!))!)
        let hello = "hello"
        do {
            lockForCarrier = XCTestExpectation(description: "wait for carrier add friend")
            lockForRobot = XCTestExpectation(description: "wait for robot receve request")
            try carrier?.addFriend(robot.robotAddress!, withGreeting: hello)
            robot.readForRobotInfo(lockForRobot!)
            
            // wait for friend_added() callback to be invoked.
            wait(for: [lockForCarrier!,lockForRobot!], timeout: timeout)
            let robotReadInfo = helper.arraryFromData(robot.readInfo)
            XCTAssertEqual(2, robotReadInfo.count)
            XCTAssertEqual("hello", robotReadInfo[0])
            XCTAssertEqual(hello, robotReadInfo[1])
            
            let carrierId = carrier?.getUserId()
            lockForRobot = XCTestExpectation(description: "wait for robot accept request")
            lockForCarrier = XCTestExpectation(description: "wait for carrier")
            XCTAssertTrue(robot.writeCmd("faccept \(carrierId!)\n", lockForRobot!))
            wait(for: [lockForCarrier!], timeout: timeout)
            let robotAcceptInfo = helper.arraryFromData(robot.readInfo)
            XCTAssertEqual(2, robotAcceptInfo.count)
            XCTAssertEqual("fadd", robotAcceptInfo[0])
            XCTAssertEqual("succeeded", robotAcceptInfo[1])
        } catch {
            print(error)
        }
    }
    
    func testBAcceptFriend() {
        lockForCarrier = XCTestExpectation(description: "wait for carrier remove robot")
        lockForRobot = XCTestExpectation(description: "wait for robot remove carrier")
        helper.removeFriendAnyway(carrier!, robot, lockForCarrier!, lockForRobot!)
        XCTAssertFalse((carrier?.isFriend(with: robot.robotId!))!)
        let hello = "hello"
        let carrierId = carrier?.getUserId()
        let carrierAddress = carrier?.getAddress()
        lockForRobot = XCTestExpectation(description: "wait for robot add friend")
        lockForCarrier = XCTestExpectation(description: "wait for carrier recevice request")
        let result = robot.writeCmd("fadd \(carrierId!) \(carrierAddress!) \(hello)\n", lockForRobot!)
        XCTAssertTrue(result)
        // wait for friend_request callback invoked;
        wait(for: [lockForCarrier!], timeout: timeout)
        XCTAssertEqual(robot.robotId, context.from)
        XCTAssertEqual(hello, context.hello)
        lockForCarrier = XCTestExpectation(description: "wait for carrier accept friend")
        lockForRobot = XCTestExpectation(description: "wait for robot")
        do {
            try carrier?.acceptFriend(with: robot.robotId!)
        } catch {
            print(error)
        }
        robot.readForRobotInfo(lockForRobot!)
        wait(for: [lockForCarrier!,lockForRobot!], timeout: timeout)
        let robotInfo = helper.arraryFromData(robot.readInfo)
        XCTAssertTrue((carrier?.isFriend(with: robot.robotId!))!)
        XCTAssertEqual(2, robotInfo.count)
        XCTAssertEqual("fadd", robotInfo[0])
        XCTAssertEqual("succeeded", robotInfo[1])
    }
    
    func testCAddFriendBeFriend() {
        do {
            _ = carrier?.isFriend(with: robot.robotId!)
            try carrier?.addFriend(robot.robotAddress!, withGreeting: "hello")
        } catch {
            let err = "0x8\(String(getErrorCode(),radix:16))"
            XCTAssertEqual("0x8100000b", err)
        }
    }
    
    func testDAddSelfBeFriend() {
        do {
            let carrierId = carrier?.getUserId()
            try carrier?.addFriend(carrierId!, withGreeting: "hello")
        } catch {
            let err = "0x8\(String(getErrorCode(),radix:16))"
            XCTAssertEqual("0x81000001", err)
        }
    }
    
    override func tearDown() {
        carrier?.kill()
    }
}
