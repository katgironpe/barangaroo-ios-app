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
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let context = appDelegate.persistentContainer.viewContext
    
    let entity = NSEntityDescription.entity(forEntityName: "BarangarooInfo", in: context)
    let bInfo = NSManagedObject(entity: entity!, insertInto: context)
    
    bInfo.setValue("foobar", forKey: "text")
    
    do {
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

      // Details
      if let detailsUrl = URL(string: "https://api.myjson.com/bins/7wkfr") {
        let detailsRequest = URLRequest(url: detailsUrl)
        let dataTask = sharedSession.dataTask(with: detailsRequest, completionHandler: { (data, response, error) -> Void in
  
          guard let content = data else {
            print("There seems to be no data")
            return
          }
          
          guard let jsonData = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
            print("No JSON data")
            return
          }
          
          if let placeDescription = jsonData["description"] as? [String] {
            bInfo.setValue(placeDescription, forKey: "text")
          }
          
          if let link = jsonData["barangaroo"] as? [String] {
            bInfo.setValue(link, forKey: "link")
          }
        })
        
        dataTask.resume()
      }
  
      
      try context.save()
    } catch {
      print("Failed saving")
    }
    
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BarangarooInfo")
    request.returnsObjectsAsFaults = false
    
    do {
      let result = try context.fetch(request)
      
      for data in result as! [NSManagedObject] {
        print("DATA", data)
      }
    } catch {
      print("Failed to retrieve image")
    }

  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}
