//
//  DetailViewController.swift
//  RotatingPlayer
//
//  Created by calvin on 18/6/2016.
//  Copyright © 2016年 me.calvinchankf. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  
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
  
  override func viewWillAppear(animated: Bool) {
    navigationController?.setNavigationBarHidden(true, animated: false)
  }
  
  @IBAction func backButtonPressed(sender: AnyObject) {
    playerControllerView.removePlayer()
    self.navigationController?.setNavigationBarHidden(false, animated: false)
    navigationController?.popViewControllerAnimated(true)
  }
  
  override func prefersStatusBarHidden() -> Bool {
    return true
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

extension DetailViewController: PlayerControllerViewDelegate {
  
  func userWantFullScreen() {
    guard let fullscreenVC = self.storyboard?.instantiateViewControllerWithIdentifier("LandscapeViewController") as? LandscapeViewController else {return}
    
    fullscreenVC.playerControllerView = playerControllerView
    self.presentViewController(fullscreenVC, animated: false, completion: nil)
  }
  
  func userWantSmallScreen() {
    
    dismissViewControllerAnimated(false) { 
      
      self.addPlayerController()
      
      // 1 pretend lanscape full screen
      let screenWidth = ScreenHelper.width()
      let screenHeight = ScreenHelper.height()
      
      var transform = self.playerControllerView.transform
      let scaleT = CGAffineTransformMakeScale(16/9, 16/9)
      transform = CGAffineTransformConcat(transform, scaleT)
      let tempY = (screenHeight-screenWidth*9/16)/2
      let translateT = CGAffineTransformMakeTranslation(tempY, 0)
      transform = CGAffineTransformConcat(transform, translateT)
      let rotateT = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
      self.playerControllerView.transform = CGAffineTransformConcat(transform, rotateT)
      
      // 2 back to small screen
      UIView.animateWithDuration(0.3, animations: {
        
        self.playerControllerView.transform = CGAffineTransformIdentity
        self.playerControllerView.playerView.updateVideoLayerFrame()
        
      }) { (finished) in
        //
      }
      
    }
    
  }
}