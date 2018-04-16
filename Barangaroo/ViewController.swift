//
//  ViewController.swift
//  Barangaroo
//  This project shows data about Barangaroo, NSW, Australia
//
//  I currently work for a GIS company based in Barangaroo, and this is the simplest app I could think of
//  It reads data from this API: https://api.myjson.com/bins/7wkfr
//
//  Created by Katherine Pe on 15/4/18.
//  Copyright © 2018 Katherine Pe. All rights reserved.
//

import UIKit
import Mapbox

class ViewController: UIViewController, MGLMapViewDelegate {
  var mapView: MGLMapView!
    
  override func viewDidLoad() {
    super.viewDidLoad()
    
    mapView = MGLMapView(frame: view.bounds, styleURL: MGLStyle.satelliteStyleURL())
    
    mapView.attributionButton.tintColor = .white
    
    mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    
    view.addSubview(mapView)
    
    // Remember to set the delegate.
    mapView.delegate = self
    
    addAnnotation()
  }
  
  func addAnnotation() {
    let annotation = MGLPointAnnotation()
    annotation.coordinate = CLLocationCoordinate2D(latitude: -33.8627536, longitude: 151.2005588)
    annotation.title = "Barangaroo"
    annotation.subtitle = "\(annotation.coordinate.latitude), \(annotation.coordinate.longitude)"
    
    mapView.addAnnotation(annotation)
    
    // Center the map on the annotation.
    mapView.setCenter(annotation.coordinate, zoomLevel: 14, animated: false)
    
    // Pop-up the callout view.
    mapView.selectAnnotation(annotation, animated: true)
  }
  
  func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
    return true
  }
  
  func mapView(_ mapView: MGLMapView, leftCalloutAccessoryViewFor annotation: MGLAnnotation) -> UIView? {
    if (annotation.title! == "Barangaroo") {
      // Callout height is fixed; width expands to fit its content.
      let label = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: 50))
      label.textAlignment = .right
      label.textColor = UIColor(red: 0.81, green: 0.71, blue: 0.23, alpha: 1)
      label.text = "NSW, Australia"
      
      return label
    }
    
    return nil
  }
  
  func mapView(_ mapView: MGLMapView, rightCalloutAccessoryViewFor annotation: MGLAnnotation) -> UIView? {
    return UIButton(type: .detailDisclosure)
  }
  
  func mapView(_ mapView: MGLMapView, annotation: MGLAnnotation, calloutAccessoryControlTapped control: UIControl) {
    // Hide the callout view.
    mapView.deselectAnnotation(annotation, animated: false)
   
    // Show the info view
    // This has an image and description of Barangaroo

    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let controller = storyboard.instantiateViewController(withIdentifier: "InfoView")
    
    self.present(controller, animated: true, completion: nil)
  }
}
