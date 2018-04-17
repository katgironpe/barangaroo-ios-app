//
//  DetailsViewController.swift
//  Barangaroo
//
//  Created by Katherine Pe on 16/4/18.
//  Copyright © 2018 Katherine Pe. All rights reserved.
//

import UIKit
import CoreData


class DetailsViewController: UIViewController {
  @IBOutlet weak var imageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let sharedSession = URLSession.shared
    
    if let url = URL(string: "https://goo.gl/P7Ns9N") {
      let imageRequest = URLRequest(url: url)
      let dataTask = sharedSession.dataTask(with: imageRequest, completionHandler: { (data, response, error) -> Void in
        
        if let data = data {
          let decodedImage = UIImage(data: data)
    
          DispatchQueue.main.async {
            self.imageView.image = decodedImage
          }
        }
      })
      
      dataTask.resume()
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}
