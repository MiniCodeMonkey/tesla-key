//
//  ViewController.swift
//  teslakey
//
//  Created by Mathias Hansen on 12/10/16.
//  Copyright © 2016 dotsquare. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var nrfManager:NRFManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nrfManager = NRFManager(
            onConnect: {
                print("Connected")
                self.sendData()
            },
            onDisconnect: {
                print("Disconnected")
            },
            onData: {
                (data:Data?, string:String?)->() in
                print("Received data - String: \(string) - Data: \(data)")
            }
        )
    }
    
    func sendData() {
        let result = self.nrfManager.writeString("Hello, world!")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

