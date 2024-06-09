//
//  MapView.swift
//  RideLink
//
//  Created by 澤木柊斗 on 2024/04/26.
//

import Foundation
import UIKit
import SwiftUI
import MapKit
import SnapKit
import Combine

struct MapView: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIViewController
    
    func makeUIViewController(context: Context) -> UIViewController {
        return MapViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}

class MapViewController: UIViewController {
    private var destinationName: String = ""
    private var touringComment: String = ""
    var mapViewModel: MapViewModel!
    init() {
        let encountRepo = EncounterRepository()
        mapViewModel = MapViewModel(encountRepository: encountRepo)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapViewModel.requestLocationAuthorization()
        mapView.delegate = self
        view.addSubview(mapView)

    lazy var mapView: MKMapView = {
        let map = MKMapView()
        var region: MKCoordinateRegion = map.region
        region.center = map.userLocation.coordinate
        region.span.latitudeDelta = 0.01
        region.span.longitudeDelta = 0.01
        map.setRegion(region, animated: true)
        map.mapType = .standard
        map.userTrackingMode = .follow
        map.frame = view.bounds

        return map
    }()
}

extension MapViewController {

    func createAnnotations(location: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        self.mapView.addAnnotation(annotation)
    }

    func createRoot(location: CLLocationCoordinate2D) {
        let sourcePlaceMark = MKPlacemark(coordinate: self.mapView.userLocation.coordinate)
        let distinationPlaceMark = MKPlacemark(coordinate: location)
        let directionRequest = MKDirections.Request()
        directionRequest.source = MKMapItem(placemark: sourcePlaceMark)
        directionRequest.destination = MKMapItem(placemark: distinationPlaceMark)
        directionRequest.transportType = .automobile
        let directions = MKDirections(request: directionRequest)
        directions.calculate { (response, error) in
            guard let directionResonse = response else {
                if let error = error {
                    print("we have error getting directions==\(error.localizedDescription)")
                }
                return
            }
            let route = directionResonse.routes[0]
            self.mapView.addOverlay(route.polyline, level: .aboveRoads)
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .blue
            renderer.lineWidth = 3
            return renderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }
}


