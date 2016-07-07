//
//  InvScannerView.swift
//  Inventory
//
//  Created by Tom Seago on 7/6/16.
//  Copyright © 2016 BAAAHS. All rights reserved.
//

import UIKit
import AVFoundation

protocol InvScannerViewDelegate {
    func scanningStarted()
    func scanningStopped()
    func codeScanned(code: String)
}

class InvScannerView : UIView, AVCaptureMetadataOutputObjectsDelegate {
    
//    static let NOTIF_NEW_CODE_SCANNED = "NOTIF_NEW_CODE_SCANNED"
//    static let NOTIF_SCANNING_STARTED = "NOTIF_SCANNING_STARTED"
//    static let NOTIF_SCANNING_STOPPED = "NOTIF_SCANNING_STOPPED"
    
    let session = AVCaptureSession()
    
    var input : AVCaptureDeviceInput!
    var previewLayer : AVCaptureVideoPreviewLayer?
    
    var lastValue = ""
    var readCode = false
    
    var delegate : InvScannerViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    deinit {
        session.stopRunning()
    }

    func setup() {
        session.sessionPreset = AVCaptureSessionPresetMedium
        
        let viewLayer = self.layer
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        
        if let previewLayer = previewLayer {
            previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
            viewLayer.addSublayer(previewLayer)
        }
        
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        do {
            try input = AVCaptureDeviceInput(device: device)
        } catch {
            setError("Failed to init capture device \(error)")
            return
        }
        
        session.addInput(input)
        
        // Setup a metadata output
        let metadataOutput = AVCaptureMetadataOutput()
        session.addOutput(metadataOutput)
        
        // TODO: make our own queue here
        // var q = dispatch_queue_create("codeQueue", nil)
        metadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        print("Available types \(metadataOutput.availableMetadataObjectTypes)")
        metadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        
        startScanning()
        
//        setNeedsLayout()
//        layoutIfNeeded()
    }
    
    func startScanning() {
        if input != nil {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
                self.lastValue = ""
                self.readCode = false
                self.session.startRunning()
                if let delegate = self.delegate {
                    dispatch_async(dispatch_get_main_queue()) {
                        delegate.scanningStarted()
                    }
                }
//                NSNotificationCenter.defaultCenter().postNotificationName(InvScannerView.NOTIF_SCANNING_STARTED, object: nil)
            }
        }
    }
    
    func stopScanning() {
        if input != nil {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
                self.session.stopRunning()
                
                if let delegate = self.delegate {
                    dispatch_async(dispatch_get_main_queue()) {
                        delegate.scanningStopped()
                    }
                }
//                NSNotificationCenter.defaultCenter().postNotificationName(InvScannerView.NOTIF_SCANNING_STOPPED, object: nil)
            }
        }
    }
    
    func toggleScanning() {
        if session.running {
            stopScanning()
        } else {
            startScanning()
        }
    }
    
    func setError(msg: String) {
        print("Error \(msg)")
    }
    
    override func layoutSubviews() {
        if let previewLayer = previewLayer {
            previewLayer.frame = self.layer.bounds
        }
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {

        for obj in metadataObjects {
            if let meta = obj as? AVMetadataMachineReadableCodeObject {
                if meta.stringValue != lastValue {
                    lastValue = meta.stringValue
                    readCode = true
                    
                    print("Got got \(lastValue)")

                    if let delegate = self.delegate {
                        dispatch_async(dispatch_get_main_queue()) {
                            delegate.codeScanned(meta.stringValue)
                        }
                    }
//                    NSNotificationCenter.defaultCenter().postNotificationName(InvScannerView.NOTIF_NEW_CODE_SCANNED, object: lastValue)
                }
            }
        }
    }
}
