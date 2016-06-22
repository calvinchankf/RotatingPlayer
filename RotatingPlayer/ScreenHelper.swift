//
//  ScreenHelper.swift
//  RotatingPlayer
//
//  Created by calvin on 18/6/2016.
//  Copyright © 2016年 me.calvinchankf. All rights reserved.
//

import UIKit

class ScreenHelper: NSObject {
  class func width() -> CGFloat {
    return UIScreen.mainScreen().bounds.size.width
  }
  
  class func height() -> CGFloat {
    return UIScreen.mainScreen().bounds.size.height
  }
}
