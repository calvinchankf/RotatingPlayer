//
//  PlayerControllerView.swift
//  RotatingPlayer
//
//  Created by calvin on 18/6/2016.
//  Copyright © 2016年 me.calvinchankf. All rights reserved.
//

import UIKit
import AVFoundation

protocol PlayerControllerViewDelegate: class {
  func userWantFullScreen()
  func userWantSmallScreen()
}

class PlayerControllerView: UIView {
  
  @IBOutlet weak var playerView: PlayerView!
  var player: AVPlayer?
  @IBOutlet weak var sizeToggleButton: UIButton!
  weak var delegate: PlayerControllerViewDelegate?
  
  var isFullscreen = false
  
  func loadVideo() {
    
    if let videoPath = NSBundle.mainBundle().pathForResource("test", ofType: "mp4") {
      let videoURL = NSURL(fileURLWithPath: videoPath)
      let avAsset = AVURLAsset(URL: videoURL)
      let keys = [ "duration" ]
      
      avAsset.loadValuesAsynchronouslyForKeys(keys) { [weak self] () -> () in
        self?.videoAssetLoaded(avAsset)
      }
    }
    
  }
  
  func videoAssetLoaded(videoAsset: AVURLAsset) {
    
    dispatch_async(dispatch_get_main_queue()) { [weak self] () -> () in
      
      guard let weakSelf = self else { return }
      
      let playerItem = AVPlayerItem(asset: videoAsset)
      playerItem.addObserver(weakSelf, forKeyPath: "status", options: .New, context: nil)
      NSNotificationCenter.defaultCenter().addObserver(weakSelf, selector: #selector(PlayerControllerView.playerItemDidPlayToEnd), name: AVPlayerItemDidPlayToEndTimeNotification, object: playerItem)
      
      weakSelf.player = AVPlayer(playerItem: playerItem)
      weakSelf.player?.actionAtItemEnd = AVPlayerActionAtItemEnd.None
      weakSelf.playerView.player = weakSelf.player
      weakSelf.playVideo()
      
    }
  }
  
  override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
    
    if let currentItem = self.player?.currentItem {
      if object as? AVPlayerItem == currentItem && keyPath == "status" {
        
        if currentItem.status == AVPlayerItemStatus.Failed {
          print("Failed")
        } else if currentItem.status == AVPlayerItemStatus.ReadyToPlay {
          print("ReadyToPlay")
        }
        
      }
    }
  }
  
  func playVideo() {
    player?.play()
  }
  
  func pauseVide() {
    player?.pause()
  }
  
  func playerItemDidPlayToEnd() {
    self.player?.seekToTime(kCMTimeZero)
  }
  
  func removePlayer() {
    player?.currentItem?.removeObserver(self, forKeyPath: "status")
    
    NSNotificationCenter.defaultCenter().removeObserver(self)
    player?.pause()
    player = nil
  }
  
  @IBAction func sizeTogglePressed(sender: AnyObject) {
    if isFullscreen {
      delegate?.userWantSmallScreen()
    } else {
      delegate?.userWantFullScreen()
    }
    isFullscreen = !isFullscreen
  }
  
}
