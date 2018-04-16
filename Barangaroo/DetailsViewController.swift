//
//  DetailsViewController.swift
//  Barangaroo
//
//  Created by Katherine Pe on 16/4/18.
//  Copyright © 2018 Katherine Pe. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
    super.viewDidLoad()
      // Obtain Reference to Shared Session
      let sharedSession = URLSession.shared
      
      if let url = URL(string: "https://goo.gl/P7Ns9N") {

        let request = URLRequest(url: url)
        
        let dataTask = sharedSession.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
          if let data = data, let image = UIImage(data: data) {
            DispatchQueue.main.async {
              self.imageView.image = image
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
