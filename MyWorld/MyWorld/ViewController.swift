//
//  ViewController.swift
//  MyWorld
//
//  Created by Christopher Wainwright Aaron on 5/21/15.
//  Copyright (c) 2015 Chris Aaron. All rights reserved.
//

import UIKit
import MapKit

class MyAnnotation: MKPointAnnotation {
    
    var venueIndex: Int!
}

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    
    @IBOutlet weak var myMapView: MKMapView!
    
    var lManager = CLLocationManager()
    
    var allvenues: [[String:AnyObject]] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        lManager.requestWhenInUseAuthorization()
        lManager.delegate = self
        
        myMapView.showsUserLocation = true
        myMapView.userTrackingMode = .Follow
        myMapView.delegate = self
        
        lManager.startUpdatingLocation()
        
        navigationController?.navigationBar.barTintColor = UIColor(red:0.99, green:0.76, blue:0.21, alpha:1)
        
        navigationItem.title = "Venues"
        
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        if let location = locations.first as? CLLocation {
            
            println("latitude \(location.coordinate.latitude) longitude \(location.coordinate.longitude)")
            
            requestVenuesWithLocation(location, completion: { (venues) -> () in
                
                self.allvenues = venues as! [[String:AnyObject]]
                
                for (index, venue) in enumerate(venues as! [[String:AnyObject]]) {
                    
                    if let locationInfo = venue["location"] as? [String:AnyObject] {
                        
                        if let lat = locationInfo["lat"] as? Double, let lng = locationInfo["lng"] as? Double {
                            
                            let coordinate = CLLocationCoordinate2DMake(lat, lng)
                            
                            let annotation = MyAnnotation()
                            
                            annotation.title = venue["name"] as? String
                            annotation.venueIndex = index
                            annotation.coordinate = coordinate
                            
                            self.myMapView.addAnnotation(annotation)
                        }
                    }
                    
                }
            })
            
            lManager.stopUpdatingLocation()
        }
    }
    
    
    func requestVenuesWithLocation(location: CLLocation, completion: (venues: [AnyObject]) -> ()) {
        
        let API_URL = "https://api.foursquare.com/v2/"
        let CLIENT_ID = "RFJJXXB1CWAJ44PK1PSDZWGHTNHXHGXHMZ31QFT4ON2BJINM"
        let CLIENT_SECRET = "IICKLN40EKQI0O21KSJ3IW0WHYJVBNOJMPJXBE3GMSNXVYDK"
        
        let endpoint = API_URL + "venues/search?client_id=\(CLIENT_ID)&client_secret=\(CLIENT_SECRET)&ll=\(location.coordinate.latitude),\(location.coordinate.longitude)&v=20150101"
        
        println(endpoint)
        
        if let url = NSURL(string: endpoint) {
            
            let request = NSURLRequest(URL: url)
            
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (request, data, error) -> Void in
                
                //data is the information returned
                
                if let returnedInfo = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as? [String:AnyObject] {
                    
                    println(returnedInfo)
                    
                    if let responseInfo = returnedInfo["response"] as? [String:AnyObject] {
                        
                        if let venuesInfo = responseInfo["venues"] as? [AnyObject] {
                            
                            completion(venues: venuesInfo)
                            
                        }
                    }
                }
                
                
            })
        }
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        
        if annotation is MKUserLocation { return nil }
        
        var annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "annotation")
        
        annotationView.canShowCallout = true
        annotationView.pinColor = MKPinAnnotationColor.Green
        
        var button = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as! UIButton
        annotationView.rightCalloutAccessoryView = button
        
        button.tag = (annotation as! MyAnnotation).venueIndex
        
        button.addTarget(self, action: "showMoreInfo:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        return annotationView
    }
    
    func showMoreInfo(shotCaller: UIButton) {
        
        var detailVC = UIViewController()
        
        var venue = allvenues[shotCaller.tag]
        
        detailVC.view.backgroundColor = UIColor.whiteColor()
        
        detailVC.navigationItem.title = venue["name"] as? String
        
        var staticCategoryLabel = UILabel(frame: CGRectMake(100, 80, 180, 20))
        staticCategoryLabel.textColor = UIColor.grayColor()
        staticCategoryLabel.text = "Category"
        
        var bar1 = UILabel(frame: CGRectMake(80, 80, 7, 70))
        bar1.backgroundColor = UIColor(red:0.69, green:0.69, blue:0.69, alpha:1)
        
        detailVC.view.addSubview(bar1)
        detailVC.view.addSubview(staticCategoryLabel)
        
        var staticAddressLabel = UILabel(frame: CGRectMake(100, 180, 180, 20))
        staticAddressLabel.text = "Address"
        staticAddressLabel.textColor = UIColor.grayColor()
        
        var bar2 = UILabel(frame: CGRectMake(80, 180, 7, 220))
        bar2.backgroundColor = UIColor(red:0.69, green:0.69, blue:0.69, alpha:1)
        
        detailVC.view.addSubview(bar2)
        detailVC.view.addSubview(staticAddressLabel)
        
        var staticHereNowLabel = UILabel(frame: CGRectMake(100, 450, 180, 20))
        staticHereNowLabel.text = "HereNow"
        staticHereNowLabel.textColor = UIColor.grayColor()
        
        var bar3 = UILabel(frame: CGRectMake(80, 450, 7, 60))
        bar3.backgroundColor = UIColor(red:0.69, green:0.69, blue:0.69, alpha:1)
        
        detailVC.view.addSubview(staticHereNowLabel)
        detailVC.view.addSubview(bar3)
        
        var statsLabel = UILabel(frame: CGRectMake(100, 280, 50, 20))
        statsLabel.text = "Stats"
        statsLabel.textColor = UIColor.grayColor()
        
        var statCircleUsers = UILabel(frame:CGRectMake(100, 320, 50, 50))
        statCircleUsers.layer.cornerRadius = 25
        statCircleUsers.backgroundColor = UIColor(red:0.69, green:0.69, blue:0.69, alpha:1)
        statCircleUsers.clipsToBounds = true
        statCircleUsers.textColor = UIColor.whiteColor()
        
        var staticUsersLabel = UILabel(frame: CGRectMake(105, 380, 100, 20))
        staticUsersLabel.text = "USERS"
        staticUsersLabel.textColor = UIColor.grayColor()
        staticUsersLabel.font = UIFont(name: "helvetica neue", size: 12)
        
        var statCircleCheckins = UILabel(frame: CGRectMake(160, 320, 50, 50))
        statCircleCheckins.layer.cornerRadius = 25
        statCircleCheckins.backgroundColor = UIColor(red:0.69, green:0.69, blue:0.69, alpha:1)
        statCircleCheckins.clipsToBounds = true
        statCircleCheckins.textColor = UIColor.whiteColor()
        
        var staticCheckinsLabel = UILabel(frame: CGRectMake(160, 380, 100, 20))
        staticCheckinsLabel.text = "CHECKINS"
        staticCheckinsLabel.textColor = UIColor.grayColor()
        staticCheckinsLabel.font = UIFont(name: "helvetica neue", size: 12)
        
        var statCircleTips = UILabel(frame: CGRectMake(220, 320, 50, 50))
        statCircleTips.layer.cornerRadius = 25
        statCircleTips.backgroundColor = UIColor(red:0.69, green:0.69, blue:0.69, alpha:1)
        statCircleTips.clipsToBounds = true
        statCircleTips.textColor = UIColor.whiteColor()
        
        var staticTipsLabel = UILabel(frame: CGRectMake(233, 380, 100, 20))
        staticTipsLabel.text = "TIPS"
        staticTipsLabel.textColor = UIColor.grayColor()
        staticTipsLabel.font = UIFont(name: "helvetica neue", size: 12)
        
        if let location = venue["location"] as? [String:AnyObject] {
            
            
            var dynamicAddressLabel = UILabel(frame: CGRectMake(100, 200, 200, 40))
            dynamicAddressLabel.text = location["address"] as? String
            
            detailVC.view.addSubview(dynamicAddressLabel)
            
        }
        
        if let categories = venue["categories"] as? [[String:AnyObject]] {
            
            var dynamicCategoryLabel = UILabel(frame: CGRectMake(100, 100, 100, 40))
            let insideCategoriesArray = categories[0]
            let categoriesName: AnyObject? = insideCategoriesArray["name"]
            dynamicCategoryLabel.text = categoriesName as? String
            
            detailVC.view.addSubview(dynamicCategoryLabel)
        }
        
        if let stats = venue["stats"] as? [String:AnyObject] {
            statCircleUsers.text = stats["usersCount"] as? String
            statCircleCheckins.text = stats["checkinsCount"] as? String
            statCircleTips.text = stats["tipCount"] as? String
        }
        
        detailVC.view.addSubview(statsLabel)
        detailVC.view.addSubview(statCircleUsers)
        detailVC.view.addSubview(staticUsersLabel)
        detailVC.view.addSubview(statCircleCheckins)
        detailVC.view.addSubview(staticCheckinsLabel)
        detailVC.view.addSubview(statCircleTips)
        detailVC.view.addSubview(staticTipsLabel)
        
        if let hereNow = venue["hereNow"] as? [String:AnyObject] {
            var hereNowLabel = UILabel(frame: CGRectMake(100, 475, 150, 40))
            hereNowLabel.text = hereNow["summary"] as? String
            
            detailVC.view.addSubview(hereNowLabel)
        }
        
        if let icon = venue["categories"] as? [[String:AnyObject]] {
            var iconPic = UILabel(frame: CGRectMake(40, 80, 40, 40))
            let inCategoriesArray = icon[0]
            let iconImage: AnyObject? = inCategoriesArray["icon"]
 //           iconPic.addSubview(iconImage) as UIImage
            }
            
        
        
        
        
        navigationController?.pushViewController(detailVC, animated: true)
        
        println("New York")
        
    }
    
}




















