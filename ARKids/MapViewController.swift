//
//  MapViewController.swift
//  ARKids
//
//  Created by Alexander on 26.09.2019.
//  Copyright © 2019 Victor Sobolev. All rights reserved.
//

import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        mapView.showsUserLocation = true
        mapView.delegate = self
        
        let coordinate = CLLocationCoordinate2D(latitude: 50.07760, longitude: 14.41411)
        
        let mark = MKPointAnnotation()
        mark.title = "Alex | 100$"
        mark.coordinate = coordinate
        mapView.addAnnotation(mark)
        
        var mapRegion = MKCoordinateRegion()
        mapRegion.center = coordinate
        mapRegion.span.latitudeDelta = 0.001
        mapRegion.span.longitudeDelta = 0.001
        
        mapView.setRegion(mapRegion, animated: true)
        
        mapView.showAnnotations([mark], animated: true)
    }
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let vc = UserInterfaceService.storyboard(identifier: "QRViewController").instantiateInitialViewController()!
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        let reuseIdentifier = "annotationView"
        var view = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        if view == nil {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
        }
        view?.displayPriority = .required
        view?.annotation = annotation
        view?.canShowCallout = false
        return view
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.first else { return }
//        mapView.setCenter(location.coordinate, animated: true)
    }
}
