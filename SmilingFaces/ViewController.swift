//
//  ViewController.swift
//  SmilingFaces
//
//  Created by Lum Situ on 3/15/17.
//  Copyright © 2017 Lum Situ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var arrayImageView: UIImageView!
    @IBOutlet weak var trayView: UIView!
    
    var newlyCreatedFace: UIImageView!
    var newLyCreatedCenter: CGPoint!
    var originalCenter: CGPoint!
    var traycenterOpen: CGPoint!
    var traycenterClose: CGPoint!
    var newPosition : CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        traycenterOpen = CGPoint(x:trayView.center.x,y:trayView.center.y)
        traycenterClose = CGPoint(x:trayView.center.x,y:trayView.center.y + 260)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    @IBAction func onTrayPanGesture(_ sender: UIPanGestureRecognizer) {
        // Absolute (x,y) coordinates in parentView
        let location = sender.location(in: view)
        let translation = sender.translation(in: view)
        let velocity = sender.velocity(in: trayView)
        
        if velocity.y > 0 {
            trayView.center = traycenterClose
            arrayImageView.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
            //CGAffineTransform.identity.rotated(by: CGFloat(M_PI)) //another way to rotate
            
            //arrayImageView.transform.rotated(by: 360.0 * CGFloat(M_PI) / 360.0) //don't know if this work or not
        } else {
            trayView.center = traycenterOpen
            arrayImageView.transform = CGAffineTransform.identity.rotated(by: CGFloat(M_PI) * 2.0)
        }
        if (sender.state == UIGestureRecognizerState.began) {
            NSLog("Gesture began at: %@", NSStringFromCGPoint(location));
            
            originalCenter = trayView.center
            
        } else if (sender.state == UIGestureRecognizerState.changed) {
            NSLog("Gesture changed at: %@", NSStringFromCGPoint(location));
            
            trayView.center = CGPoint(x:originalCenter.x, y:originalCenter.y + translation.y);
            
        } else if (sender.state == UIGestureRecognizerState.ended) {
            NSLog("Gesture ended at: %@", NSStringFromCGPoint(location));
        }
    }
    
    @IBAction func movemoji(_ sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        
        let uimgview = sender.view as! UIImageView
        
        if (sender.state == UIGestureRecognizerState.began) {
            NSLog("Begin");
            self.newlyCreatedFace = UIImageView.init(image: uimgview.image)
            self.view.addSubview(self.newlyCreatedFace)
            
            self.newlyCreatedFace.center = uimgview.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            newLyCreatedCenter = newlyCreatedFace.center
            
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didFacePan(sender:)))
            newlyCreatedFace.isUserInteractionEnabled = true
            newlyCreatedFace.addGestureRecognizer(panGestureRecognizer)
            
            let scaleGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(didFaceScale(sender:)))
            newlyCreatedFace.addGestureRecognizer(scaleGestureRecognizer)
            
            let rotateGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(didFaceRotate(sender:)))
            newlyCreatedFace.addGestureRecognizer(rotateGestureRecognizer)
            
            let deleteFaces = UITapGestureRecognizer(target: self, action: #selector(deleteFace(sender:)))
            deleteFaces.numberOfTapsRequired = 2
            newlyCreatedFace.addGestureRecognizer(deleteFaces)
            
        } else if (sender.state == UIGestureRecognizerState.changed) {
            NSLog("Changed");
            self.newlyCreatedFace.center = CGPoint(x:newLyCreatedCenter.x + translation.x, y: newLyCreatedCenter.y + translation.y)
            
        } else if (sender.state == UIGestureRecognizerState.ended) {
            NSLog("Ended");
            
        }
    }
    
    func didFacePan(sender: UIPanGestureRecognizer) {
        //        let location = sender.location(in: view)
        //        let veloity = sender.velocity(in: view)
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            print("Pan began")
            newlyCreatedFace = sender.view as! UIImageView
            newLyCreatedCenter = newlyCreatedFace.center
            
            UIView.animate(withDuration: 0.2, animations: {
                self.newlyCreatedFace.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            })
        } else if sender.state == .changed {
            print("Pan changed")
            newlyCreatedFace.center = CGPoint(x: newLyCreatedCenter.x + translation.x, y: newLyCreatedCenter.y + translation.y)
        } else if sender.state == .ended {
            print("Pan ended")
            self.newlyCreatedFace.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
    func didFaceScale(sender: UIPinchGestureRecognizer) {
        let scale = sender.scale
        //        var velocity = sender.velocity
        
        self.newlyCreatedFace.transform = CGAffineTransform(scaleX: scale, y: scale)
        
        //        if sender.state == .began {
        //            UIView.animate(withDuration: 0.2, animations: {
        //                print("Scaling")
        //                self.newlyCreatedFace.transform = CGAffineTransform(scaleX: scale, y: scale)
        //            })
        //        } else if sender.state == .changed {
        //
        //        } else if sender.state == .ended {
        //            self.newlyCreatedFace.transform = CGAffineTransform(scaleX: 1, y: 1)
        //        }
    }
    
    func didFaceRotate(sender: UIRotationGestureRecognizer) {
        let rotation = sender.rotation
        //        var velocity = sender.velocity
        print("Going to rotate")
        self.newlyCreatedFace.transform = CGAffineTransform(rotationAngle: 180.0 * rotation / 180.0)
    }
    
    func deleteFace(sender: UITapGestureRecognizer) {
        newlyCreatedFace.removeFromSuperview()
    }
    
    
}




