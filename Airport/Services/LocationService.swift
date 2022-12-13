//
//  LocationService.swift
//  Airport
//
//  Created by dohg on 12/12/2022.
//

import CoreLocation
import RxRelay
import RxSwift

class LocationService: NSObject {
    
    static let shared = LocationService()
    
    private let currentLocationRelay = BehaviorRelay<CLLocation?>(value: nil)
    let locationManager = CLLocationManager()
    
    var currentLocaton: Observable<CLLocation?> {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
        return currentLocationRelay.asObservable()
    }
    
    override init() {
        super.init()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
    }
    
}

extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            currentLocationRelay.accept(location)
            manager.stopUpdatingLocation()
        }
    }
    
}
