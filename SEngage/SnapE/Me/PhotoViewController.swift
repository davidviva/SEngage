//
//  PhotoViewController.swift
//  SEngage
//
//  Created by Yan Wu on 4/14/16.
//  Copyright © 2016 Avaya. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func moreAction(sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "", message: "Change your profile photo",
                                                preferredStyle: .ActionSheet)
        let cameraAction = UIAlertAction(title: "Take Photo", style: .Default, handler:{
            action in
            if UIImagePickerController.isSourceTypeAvailable(.Camera){
                // Create the image picker controller
                let picker = UIImagePickerController()
                // Set the delegate
                picker.delegate = self
                // Set the source
                picker.sourceType = UIImagePickerControllerSourceType.Camera
                picker.allowsEditing = true
                if UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.Front){
                    picker.cameraDevice = UIImagePickerControllerCameraDevice.Front
                }
                picker.cameraFlashMode = UIImagePickerControllerCameraFlashMode.Auto
                // Open the camera
                self.presentViewController(picker, animated: true, completion: { () -> Void in
                    
                })
            }else{
                print("Cannot find the camera device")
            }
        })
        let pickPhotoAction = UIAlertAction(title: "Choose from Photos", style: .Default, handler: {
            action in
            if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary){
                let picker = UIImagePickerController()
                picker.delegate = self
                picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                picker.allowsEditing = true
                self.presentViewController(picker, animated: true, completion: {
                    () -> Void in
                })
            }else{
                print("Cannot access the photo library")
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(cameraAction)
        alertController.addAction(pickPhotoAction)
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}