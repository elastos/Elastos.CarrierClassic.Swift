//
//  RobotConnector.swift
//  ElastosCarrierTests
//
//  Created by 李爱红 on 2019/3/15.
//  Copyright © 2019年 org.elastos. All rights reserved.
//

import UIKit
import XCTest
import CocoaAsyncSocket

public enum waitStatus : Int {
    case waitStatusForReady = 0
    case waitStatusForfremove = 1
    case waitStatusForfaccept = 2
    case waitStatusForfadd = 3
}

public class RobotConnector:XCTestCase, GCDAsyncSocketDelegate{
    
    static let sharedInstance: RobotConnector = { RobotConnector() }()
    let socket: GCDAsyncSocket = GCDAsyncSocket()
    let helper = TestHelper.sharedInstance
    var closure: (()->())?
    var lock: XCTestExpectation?
    let timeout: Double = 600.0
    var isTrueWriteCmd: Bool = false
    public var isConnected: Bool = false
    public var robotId: String?
    public var robotAddress: String?
    public var readInfo: Data?
    
    public func connectToRobot(_ lock: XCTestExpectation) -> Bool{
        self.lock = lock
        socket.delegate = self
        socket.delegateQueue = DispatchQueue.main
        if isConnected {
            return true
        }
        do {
            try socket.connect(toHost:Robot.ROBOTHOST , onPort: UInt16(Robot.ROBOTPORT)!, withTimeout: timeout)
        } catch  {
            isConnected = false
            print(error)
        }
        wait(for: [self.lock!], timeout: timeout)
        if isConnected {
            print("connect to robot succeed")
            let robotInfo = helper.arraryFromData(readInfo)
            robotId = robotInfo[1]
            robotAddress = robotInfo[2]
        }else {
            print("connect to robot fail")
        }
        return true
    }
    
    public func writeCmd(_ command: String, _ waitForCmd: XCTestExpectation) -> Bool{
        lock = waitForCmd
        guard isConnected else {
            print("Connection to robot is broken, write command error")
            return false
        }
        print("RobotConnector writeCmd : \(command) \n")
        let data = command.data(using: .utf8)
        socket.write(data!, withTimeout: -1, tag: 1)
        wait(for: [lock!], timeout: timeout)
        return isTrueWriteCmd
    }
    
    public func readForRobotInfo(_ lock: XCTestExpectation){
        self.lock = lock
        socket.readData(withTimeout: -1, tag: 0)
    }
    
    public func disconnect() {
        if isConnected {
            self.socket.disconnect()
        }
        readInfo = nil
        robotId = nil
        robotAddress = nil
    }
    
    public func socket(_ sock: GCDAsyncSocket, didRead data: Data, withTag tag: Int) {
        readInfo = data
        lock?.fulfill()
        let arr = helper.arraryFromData(data)
        print(arr)
    }
    
    public func socket(_ sock: GCDAsyncSocket, didConnectToHost host: String, port: UInt16) {
        sock.readData(withTimeout: -1, tag: 0)
        isConnected = true
    }
    
    public func socketDidDisconnect(_ sock: GCDAsyncSocket, withError err: Error?) {
        isTrueWriteCmd = false
        XCTAssertNotNil(err)
    }
    
    public func socket(_ sock: GCDAsyncSocket, didWriteDataWithTag tag: Int) {
        isTrueWriteCmd = true
        socket.readData(withTimeout: -1, tag: tag)
        if lock?.description == "wait for robot add friend" {
            lock?.fulfill()
        }
    }
    
}
