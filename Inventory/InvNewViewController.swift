//
//  InvNewViewController.swift
//  Inventory
//
//  Created by Tom Seago on 7/6/16.
//  Copyright © 2016 BAAAHS. All rights reserved.
//

import UIKit

class InvNewViewController : UIViewController, InvScannerViewDelegate {

    @IBOutlet weak var tfName : UITextField!
    @IBOutlet weak var tfCode : UITextField!
    @IBOutlet weak var scanView: InvScannerView!
    @IBOutlet weak var btnScan : UIButton!
    
    
    override func viewWillAppear(animated: Bool) {
        btnScan.titleLabel?.lineBreakMode = .ByWordWrapping
        scanView.delegate = self
        scanView.startScanning()
    }
//    override func viewDidAppear(animated: Bool) {
//        self.viewDidAppear(animated)
//        
//        // Start scanning?
//        if let scanView = scanView {
//            scanView.startScanning()
//        }
//    }
    
    func scanningStarted() {
        btnScan.setTitle("Stop\nScanning", forState: .Normal)
    }
    
    func scanningStopped() {
        btnScan.setTitle("Start\nScanning", forState: .Normal)
    }
    
    func codeScanned(code: String) {
        tfCode.text = code
        scanView.stopScanning()
    }
    
    @IBAction func scanButtonTapped() {
        scanView.toggleScanning()
    }
}
