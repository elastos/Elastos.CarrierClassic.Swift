//
//  TestOptions.swift
//  ElastosCarrierTests
//
//  Created by 李爱红 on 2019/3/14.
//  Copyright © 2019年 org.elastos. All rights reserved.
//

import UIKit
import ElastosCarrier

public class TestOptions {
    
    public class func options() -> CarrierOptions {
        
        let carrierDirectory: String = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0] + "/carrier"
        let options = CarrierOptions()
        options.bootstrapNodes = [BootstrapNode]()
        
        let bootstrapNode = BootstrapNode()
        bootstrapNode.ipv4 = "13.58.208.50"
        bootstrapNode.port = "33445"
        bootstrapNode.publicKey = "89vny8MrKdDKs7Uta9RdVmspPjnRMdwMmaiEW27pZ7gh"
        options.bootstrapNodes?.append(bootstrapNode)
        
        bootstrapNode.ipv4 = "18.216.102.47"
        bootstrapNode.port = "33445"
        bootstrapNode.publicKey = "G5z8MqiNDFTadFUPfMdYsYtkUDbX5mNCMVHMZtsCnFeb"
        options.bootstrapNodes?.append(bootstrapNode)
        
        bootstrapNode.ipv4 = "18.216.6.197"
        bootstrapNode.port = "33445"
        bootstrapNode.publicKey = "H8sqhRrQuJZ6iLtP2wanxt4LzdNrN2NNFnpPdq1uJ9n2"
        options.bootstrapNodes?.append(bootstrapNode)
        
        bootstrapNode.ipv4 = "54.223.36.193"
        bootstrapNode.port = "33445"
        bootstrapNode.publicKey = "5tuHgK1Q4CYf4K5PutsEPK5E3Z7cbtEBdx7LwmdzqXHL"
        options.bootstrapNodes?.append(bootstrapNode)
        
        bootstrapNode.ipv4 = "52.83.191.228"
        bootstrapNode.port = "33445"
        bootstrapNode.publicKey = "3khtxZo89SBScAMaHhTvD68pPHiKxgZT6hTCSZZVgNEm"
        options.bootstrapNodes?.append(bootstrapNode)
        options.udpEnabled = true
        options.persistentLocation = carrierDirectory
        
        return options
    }
    
}
