//
//  FirstViewController.swift
//  CameraTest
//
//  Created by Andrew Fields on 8/9/18.
//  Copyright © 2018 Andrew Fields. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
  
  static let shared = CameraHandler()
  
  fileprivate var currentVC: UIViewController!
  
  @IBOutlet weak var displayImage: UIImageView!
  @IBOutlet weak var displayImage2: UIImageView!
  
  //MARK: Internal Properties
  var imagePickedBlock: ((UIImage) -> Void)?

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func AddPhoto(_ sender: Any) {
    CameraHandler.shared.showActionSheet(vc: self)
    CameraHandler.shared.imagePickedBlock = { (image) in
      self.displayImage.image = image
      self.displayImage2.image = image
    }
  }
  
}



