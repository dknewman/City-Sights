//
//  ContentModel.swift
//  City Sights
//
//  Created by David Newman on 6/5/22.
//

import Foundation
import CoreLocation
class ContentModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    
    override init(){
        
        super.init()
        //Set Content Model as Delegate
        locationManager.delegate = self
        
        //Request permission from user
        locationManager.requestWhenInUseAuthorization()
        
        //Start GeoLocation, after permission
        // locationManager.startUpdatingLocation()
    }
    
    // MARK: - Location Manager Delegate Methods
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if locationManager.authorizationStatus == .authorizedAlways ||
            locationManager.authorizationStatus == .authorizedWhenInUse{
            
            locationManager.startUpdatingLocation()
            
        }else if locationManager.authorizationStatus == .denied {
            
            
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //Gets Location of the user
        let userLocation = locations.first
        
        if userLocation != nil {
            
            //Stop requesting location
            locationManager.stopUpdatingLocation()
            // getBusinesses(category: "arts", location: userLocation!)
            getBusinesses(category: "restaurants", location: userLocation!)
            
        }
    }
    //MARK: - Yelp API Method
    
    func getBusinesses(category: String, location:CLLocation){
        
        //create url
        //        let urlString = Const.YELP_URL_ENDPOINT +
        //        "/search?latitude=\(location.coordinate.latitude)&longitude=\(location.coordinate.longitude)&categories=\(category)&limit=6"
        //
        //        let url = URL(string: urlString)
        
        var urlComponents = URLComponents(string: Const.YELP_URL_ENDPOINT)
        urlComponents?.queryItems = [
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "categories", value: category),
            URLQueryItem(name: "limit", value: "6")
            
        ]
        
        let url = urlComponents?.url
        
        if let url = url{
            
            //create url request
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.addValue("Bearer " + Const.YELP_API_KEY, forHTTPHeaderField: "Authorization")
            //get url session
            let session = URLSession.shared
            
            //create data task
            let dataTask = session.dataTask(with: request) { data, response, error in
                //check no error
                if error == nil{
                    
                    print(response)
                }
            }
            
            //start data task
            dataTask.resume()
        }
        
    }
}
