//
//  ViewController.swift
//  SmilingFaces
//
//  Created by Lum Situ on 3/15/17.
//  Copyright © 2017 Lum Situ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
        } else {
            trayView.center = traycenterOpen
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
        
        
        
        
//        let faceCenter = CGPoint(x:self.newlyCreatedFace.center.x, y:self.newlyCreatedFace.center.y)
        
//        self.newlyCreatedFace.center = CGPoint(x: faceCenter.x, y: faceCenter.y + trayView.frame.origin.y)
        if (sender.state == UIGestureRecognizerState.began) {
            NSLog("Gesture began at: %@", NSStringFromCGPoint(translation));
            self.newlyCreatedFace = UIImageView.init(image: uimgview.image)
            self.view.addSubview(newlyCreatedFace)
            self.newlyCreatedFace.center = uimgview.center
            
        } else if (sender.state == UIGestureRecognizerState.changed) {
            NSLog("Gesture changed at: %@", NSStringFromCGPoint(translation));
            self.newlyCreatedFace.center = CGPoint(x:newlyCreatedFace.center.x + translation.x, y: newlyCreatedFace.center.y + translation.y)
            
        } else if (sender.state == UIGestureRecognizerState.ended) {
            NSLog("Gesture ended at: %@", NSStringFromCGPoint(translation));
            
            
        }
        
        
    }
    

}

