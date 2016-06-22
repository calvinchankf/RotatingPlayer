//
//  RotatingViewController.swift
//  RotatingPlayer
//
//  Created by calvin on 22/6/2016.
//  Copyright © 2016年 me.calvinchankf. All rights reserved.
//

import UIKit

class RotatingViewController: UIViewController {
  
  @IBOutlet weak var playerContainer: UIView!
  var playerControllerView: PlayerControllerView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    if let temp = NSBundle.mainBundle().loadNibNamed("PlayerControllerView", owner: self, options: nil).first as? PlayerControllerView
    {
      playerControllerView = temp
      addPlayerController()
      playerControllerView.delegate = self
      playerControllerView.loadVideo()
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func prefersStatusBarHidden() -> Bool {
    return true
  }
  
  @IBAction func rotateButtonPressed(sender: AnyObject) {
    UIDevice.currentDevice().setValue(UIDeviceOrientation.LandscapeLeft.rawValue, forKey: "orientation")
  }
  
  func addPlayerController() {
    let screenWidth = ScreenHelper.width()
    playerControllerView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenWidth*9/16)
    playerControllerView.translatesAutoresizingMaskIntoConstraints = false
    playerContainer.addSubview(playerControllerView)
    
    let top = NSLayoutConstraint(item: playerControllerView, attribute: .Top, relatedBy: .Equal, toItem: playerContainer, attribute: .Top, multiplier: 1, constant: 0)
    let bottom = NSLayoutConstraint(item: playerControllerView, attribute: .Bottom, relatedBy: .Equal, toItem: playerContainer, attribute: .Bottom, multiplier: 1, constant: 0)
    let leading = NSLayoutConstraint(item: playerControllerView, attribute: .Leading, relatedBy: .Equal, toItem: playerContainer, attribute: .Leading, multiplier: 1, constant: 0)
    let trailing = NSLayoutConstraint(item: playerControllerView, attribute: .Trailing, relatedBy: .Equal, toItem: playerContainer, attribute: .Trailing, multiplier: 1, constant: 0)
    
    playerContainer.addConstraints([top, bottom, leading, trailing])
  }
  
}

extension RotatingViewController: PlayerControllerViewDelegate {
  
  func userWantFullScreen() {
    UIDevice.currentDevice().setValue(UIDeviceOrientation.LandscapeLeft.rawValue, forKey: "orientation")
  }
  
  func userWantSmallScreen() {
    UIDevice.currentDevice().setValue(UIDeviceOrientation.Portrait.rawValue, forKey: "orientation")
  }
  
}