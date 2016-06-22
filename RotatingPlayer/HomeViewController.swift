//
//  ViewController.swift
//  RotatingPlayer
//
//  Created by calvin on 17/6/2016.
//  Copyright © 2016年 me.calvinchankf. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func pushToDetailVC(sender: AnyObject) {
    
    guard let detailVC = self.storyboard?.instantiateViewControllerWithIdentifier("DetailViewController") else {return}
    
    self.navigationController?.pushViewController(detailVC, animated: true)
  }

}

