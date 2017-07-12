//
//  MapViewController.swift
//  FoodPin
//
//  Created by 培 唐 on 2017/7/11.
//  Copyright © 2017年 唐培. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    
    @IBOutlet weak var mapView: MKMapView!
    var restaurant: Restaurant!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        //地址字符串转坐标
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(restaurant.location) { (placemarks, error) in
            if error != nil {
                print(error)
                return
            }
            //取第一个坐标
            if placemarks != nil && (placemarks?.count)! > 0 {
                let placemark = placemarks?[0]
                let annotation = MKPointAnnotation()
                annotation.title = self.restaurant.name
                annotation.subtitle = self.restaurant.type
                annotation.coordinate = (placemark?.location?.coordinate)!
                
                self.mapView.showAnnotations([annotation], animated: true)
                self.mapView.selectAnnotation(annotation, animated: true)
            }
        }
        mapView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension MapViewController: MKMapViewDelegate{
    
    func setupUI(){
        let returnBtn = UIButton(frame: CGRect(x: 12, y: kBounds.height*0.04, width: kBounds.width*0.075, height:kBounds.width*0.075))
        returnBtn.setTitle("<", for: .normal)
        returnBtn.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        returnBtn.addTarget(self, action: #selector(returnBtnClick), for: .touchUpInside)
        view.addSubview(returnBtn)
        
    }
    
    func returnBtnClick(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MyPin"
        
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil{
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        }
        
        let leftIconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 53, height: 53))
        leftIconView.image = UIImage(data: restaurant.image as Data)
        annotationView?.leftCalloutAccessoryView = leftIconView
        return annotationView
        
    }
}
