//
//  QR_ItemVC.swift
//  Inventory
//
//  Created by Michael King on 4/14/16.
//  Copyright © 2016 Michael King. All rights reserved.
//


import UIKit
import AVFoundation

class QR_ItemVC: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var capturedScan: String?
    
    @IBOutlet weak var stuffItLbl: UIButton!
 
    @IBOutlet weak var cancelLbl: UIButton!
    
    @IBAction func cancelBtn(sender: AnyObject) {
        // Hide Label and Cancel Buttons
        
        
        captureSession?.stopRunning()
        
        //removes frames from view and goes back to standard application
        qrCodeFrameView?.removeFromSuperview()
        VideoPreviewLayer?.removeFromSuperlayer()
        
        //self.dismissViewControllerAnimated(true, completion: nil)
        navigationController?.popViewControllerAnimated(true)
        
    }
    
    
    var captureSession:AVCaptureSession?
    var VideoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView: UIView?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       //don't rotation the button cancelLbl.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_4))
        
        
        //Begin Scanning
        let captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        //Handle all Errors First
        var error: NSError?
        let input:AnyObject!
        
        do {
            
            input = try AVCaptureDeviceInput(device: captureDevice)
            
        } catch let error1 as NSError {
            
            error = error1
            input = nil
            
        }
        
        if (error != nil) {
            print("\(error?.localizedDescription)")
            return
        }
        
        captureSession = AVCaptureSession()
        captureSession?.addInput(input as! AVCaptureInput)
        
        let captureMetaDataOutput = AVCaptureMetadataOutput()
        
        captureSession?.addOutput(captureMetaDataOutput)
        captureMetaDataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        captureMetaDataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        
        VideoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        VideoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        VideoPreviewLayer?.frame = view.layer.bounds
        view.layer.addSublayer(VideoPreviewLayer!)
        
        captureSession?.startRunning()
        
        // bring Label and Cancel Button to front/above of Camera layer
        //        view.bringSubviewToFront(Label)
        //        view.bringSubviewToFront(cancelButtonOutlet)
        //        view.bringSubviewToFront(openURLoutlet)
        //
        view.bringSubviewToFront(cancelLbl)
        view.bringSubviewToFront(stuffItLbl)
        
        
        qrCodeFrameView = UIView()
        qrCodeFrameView?.layer.borderColor = UIColor.greenColor().CGColor
        qrCodeFrameView?.layer.borderWidth = 2
        view.addSubview(qrCodeFrameView!)
        view.bringSubviewToFront(qrCodeFrameView!)
        
        
        
        
    }//end VIew Did Load
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        
        if metadataObjects == nil || metadataObjects.count == 0 {
            
            qrCodeFrameView?.frame = CGRectZero
            //            Label.text = "No QR Code Detected"
            return
            
        }
        
        let metaDataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metaDataObj.type == AVMetadataObjectTypeQRCode {
            
            let BarcodeObject = VideoPreviewLayer?.transformedMetadataObjectForMetadataObject(metaDataObj as AVMetadataMachineReadableCodeObject) as!AVMetadataMachineReadableCodeObject
            
            qrCodeFrameView?.frame = BarcodeObject.bounds
            
            // when QR is Detected -> Update Label and FREEZE The CAMERA
            
            if metaDataObj.stringValue != nil {
                self.capturedScan = metaDataObj.stringValue
                
                captureSession?.stopRunning()
                
                // create the alert
                let alert = UIAlertController(title: "Nothing Found", message: "Would you like to create a new box using this QR Code?", preferredStyle: UIAlertControllerStyle.Alert)
                
                
                // add the actions (buttons)
                alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: { action in
                    self.captureSession?.stopRunning()
                    
                    
                    self.performSegueWithIdentifier("NewBoxFromQR", sender: nil)
                    
                }))
                
                // add the actions (buttons)
                alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel, handler: { action in
                    
                    self.captureSession?.stopRunning()
                    
                    //removes frames from view and goes back to standard application
                    self.qrCodeFrameView?.removeFromSuperview()
                    self.VideoPreviewLayer?.removeFromSuperlayer()
                    
                    
                    
                    
                }))
                
                
                
                
                // show the alert
                self.presentViewController(alert, animated: true, completion: nil)
                
                
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("Making New Box from QR Code")
        if segue.identifier == "NewBoxFromQR" {
            
            if let destination = segue.destinationViewController as? BoxEditDetailsVC {
                
                destination.passedQR = self.capturedScan
                
            }
        }
    }
    
    
    
  

    
    
    
    @IBAction func closeAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: true)
    }
    
    
    
    
}//ViewController










