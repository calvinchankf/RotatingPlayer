//
//  PlayerView.swift
//  RotatingPlayer
//
//  Created by calvin on 18/6/2016.
//  Copyright © 2016年 me.calvinchankf. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class PlayerView: UIView {
  
  var videoLayer: AVPlayerLayer!
  var player: AVPlayer? {
    didSet {
      videoLayer = AVPlayerLayer(player: self.player)
      videoLayer.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
      self.layer.addSublayer(videoLayer)
    }
  }
  
  func updateVideoLayerFrame() {
    if let _ = videoLayer {
      videoLayer.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
    }
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.updateVideoLayerFrame()
  }
  
}
