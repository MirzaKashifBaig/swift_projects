//
//  LocationManager.swift
//  Weather_API_JSON
//
//  Created by Mirza Baig on 09/09/22.
//

import SwiftUI
import Combine
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate{
    private let locationManager = CLLocationManager()
    @Published var locationStatus: CLAuthorizationStatus?
    @Published var lastLocation: CLLocation?
    @Published var isLoading = false
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    var statusString:String{
        guard let status = locationStatus else {return "Unknown"}
        
        switch status {
        case .notDetermined:
            return "Not Determine"
        case .restricted:
            return "Restricted"
        case .denied:
            return "Denied"
        case .authorizedAlways:
            return "Aurthorized Always"
        case .authorizedWhenInUse:
            return "Authorized When In Use"
        case .authorized:
            return "Authorized"
        @unknown default:
            return "None"
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager){
        locationStatus = manager.authorizationStatus
    }
    
    func requestLocation() {
        isLoading = true
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        lastLocation = location
        isLoading = false
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
        isLoading = false
    }
    
}
