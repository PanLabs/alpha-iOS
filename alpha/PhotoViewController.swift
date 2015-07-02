//
//  PhotoViewController.swift
//  alpha
//
//  Created by Corey Howell on 6/29/15.
//  Copyright (c) 2015 Corey Howell. All rights reserved.
//

import UIKit
import MobileCoreServices
//import RebekkaTouch
//
//var _session: Session!

class PhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    
    var newMedia: Bool?
    
    @IBAction func useCamera(sender: AnyObject) {
        
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerControllerSourceType.Camera) {
                
                let imagePicker = UIImagePickerController()
                
                imagePicker.delegate = self
                imagePicker.sourceType =
                    UIImagePickerControllerSourceType.Camera
                imagePicker.mediaTypes = [kUTTypeImage as NSString]
                imagePicker.allowsEditing = false
                
                self.presentViewController(imagePicker, animated: true, 
                    completion: nil)
                newMedia = true
        }
    }
    
    @IBAction func useCameraRoll(sender: AnyObject) {
        
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerControllerSourceType.SavedPhotosAlbum) {
                let imagePicker = UIImagePickerController()
                
                imagePicker.delegate = self
                imagePicker.sourceType =
                    UIImagePickerControllerSourceType.PhotoLibrary
                imagePicker.mediaTypes = [kUTTypeImage as NSString]
                imagePicker.allowsEditing = false
                self.presentViewController(imagePicker, animated: true,
                    completion: nil)
                newMedia = false
        }
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        if mediaType == kUTTypeImage as! String {
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            //let imageUrl = info[UIImagePickerControllerMediaMetadata]! as! String

            println("\(image)")
            imageView.image = image
            
            let fileManager = NSFileManager.defaultManager()
            var paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
            var filePathToWrite = "\(paths)/SaveFile.png"
            
            var imageData: NSData = UIImagePNGRepresentation(image)
            fileManager.createFileAtPath(filePathToWrite, contents: imageData, attributes: nil)
            var getImagePath = paths.stringByAppendingPathComponent("SaveFile.png")
            
            if (fileManager.fileExistsAtPath(getImagePath))
            {
                println("FILE AVAILABLE");
 
                /*
                var configuration = SessionConfiguration()
                configuration.host = "10.0.0.1:22"
                //configuration.host = "ftp://ftp.rollsoft.net:21"
                //configuration.username = "rollsoft"
                //configuration.password = "Punkinpi3"
                configuration.username = "pi"
                configuration.password = "raspberry"

                configuration.encoding = NSUTF8StringEncoding
                _session = Session(configuration: configuration)
                
                
//                let URL = getImagePath
                let URL = NSURL(string: getImagePath)
                let path = "/testUpload.png"
                _session.upload(URL!, path: path) {
                    (result, error) -> Void in
                    println("Upload file with result:\n\(result), error: \(error)\n\n")
                }
                */
                //Pick Image and Use accordingly
                var imageis: UIImage = UIImage(contentsOfFile: getImagePath)!
                println(getImagePath)
                
                //fileManager.removeItemAtPath(getImagePath, error: "uh oh!")
                
                //let data: NSData = UIImagePNGRepresentation(imageis)
                
            }
            else
            {
                println("FILE NOT AVAILABLE");
                
            }
            
            
            
            if (newMedia == true) {
                UIImageWriteToSavedPhotosAlbum(image, self,
                    "image:didFinishSavingWithError:contextInfo:", nil)
            } else if mediaType == kUTTypeMovie as! String {
                // Code to support video here
            }
            
        }
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSErrorPointer, contextInfo:UnsafePointer<Void>) {
        
        if error != nil {
            let alert = UIAlertController(title: "Save Failed",
                message: "Failed to save image",
                preferredStyle: UIAlertControllerStyle.Alert)
            
            let cancelAction = UIAlertAction(title: "OK",
                style: .Cancel, handler: nil)
            
            alert.addAction(cancelAction)
            self.presentViewController(alert, animated: true,
                completion: nil)
        }
    }
    
//    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
//        self.dismissViewControllerAnimated(true, completion: nil)
//    }
    
    
    
    
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
