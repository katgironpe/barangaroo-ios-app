//
//  InfoViewController.swift
//  Barangaroo
//
//  Created by Katherine Pe on 17/4/18.
//  Copyright © 2018 Katherine Pe. All rights reserved.
//

import UIKit
import CoreData
import SwiftyJSON


class InfoViewController: UIViewController {
  
  @IBOutlet weak var barangarooText: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let sharedSession = URLSession.shared
    
    // Details
    if let detailsUrl = URL(string: "https://api.myjson.com/bins/7wkfr") {
      let detailsRequest = URLRequest(url: detailsUrl)
      let dataTask = sharedSession.dataTask(with: detailsRequest, completionHandler: { (data, response, error) -> Void in
        
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "BarangarooInfo", in: context)
        let bInfo = NSManagedObject(entity: entity!, insertInto: context)
        
        guard let content = data else {
          print("There seems to be no data")
          return
        }
        
        guard let jsonData = (try? JSON(data: content)) else {
          print("No JSON data")
          return
        }
        
        do {
          
          let placeDescription = jsonData["description"].string!
          let link = jsonData["barangaroo"].string!
          
          bInfo.setValue(placeDescription, forKey: "desc")
          bInfo.setValue(link, forKey: "link")
          
          
          
          
          try context.save()
        } catch {
          print("Failed saving")
        }
      })
      
      
      dataTask.resume()
    }
    
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BarangarooInfo")
    request.returnsObjectsAsFaults = false
    
    do {
      let context = appDelegate.persistentContainer.viewContext
      let result = try context.fetch(request)
    
      
      barangarooText.numberOfLines = 0
      
      for data in result as! [NSManagedObject] {
        barangarooText.text = data.value(forKey: "desc") as! String
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

