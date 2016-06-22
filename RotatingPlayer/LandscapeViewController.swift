//
//  LandscapeViewController.swift
//  RotatingPlayer
//
//  Created by calvin on 18/6/2016.
//  Copyright © 2016年 me.calvinchankf. All rights reserved.
//

import UIKit

class LandscapeViewController: UIViewController {
  
  var playerControllerView: PlayerControllerView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
    addPlayerController()
    
    // 1 pretend small screen
    let screenWidth = ScreenHelper.width()
    let screenHeight = ScreenHelper.height()
    
    var transform = playerControllerView.transform
    let scaleT = CGAffineTransformMakeScale(9/16, 9/16)
    transform = CGAffineTransformConcat(transform, scaleT)
    let tempY = (screenHeight-screenWidth*9/16)/2
    let translateT = CGAffineTransformMakeTranslation(0, -tempY)
    transform = CGAffineTransformConcat(transform, translateT)
    let rotateT = CGAffineTransformMakeRotation(CGFloat(-M_PI_2))
    playerControllerView.transform = CGAffineTransformConcat(transform, rotateT)
    
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    // 2
    UIView.animateWithDuration(0.3, animations: {
      
      self.playerControllerView.transform = CGAffineTransformIdentity
      self.playerControllerView.playerView.updateVideoLayerFrame()
      
      }) { (finished) in
        //
    }
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // orientation
  
  override func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
    return UIInterfaceOrientation.LandscapeRight
  }
  
  override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
    return UIInterfaceOrientationMask.LandscapeRight
  }
  
  override func shouldAutorotate() -> Bool {
    return true
  }
  
  func addPlayerController() {
    
    let screenWidth = ScreenHelper.width()
    let screenHeight = ScreenHelper.height()
    
    // swap width & height becox the mainScreen is still in portrait
    playerControllerView.frame = CGRect(x: 0, y: 0, width: screenHeight, height: screenWidth)
    
    playerControllerView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(playerControllerView)
    
    let top = NSLayoutConstraint(item: playerControllerView, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1, constant: 0)
    let bottom = NSLayoutConstraint(item: playerControllerView, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1, constant: 0)
    let leading = NSLayoutConstraint(item: playerControllerView, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1, constant: 0)
    let trailing = NSLayoutConstraint(item: playerControllerView, attribute: .Trailing, relatedBy: .Equal, toItem: view, attribute: .Trailing, multiplier: 1, constant: 0)
    
    view.addConstraints([top, bottom, leading, trailing])
  }
}
