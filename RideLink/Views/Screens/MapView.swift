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
    var mapViewModel: MapViewModel!


    override func viewDidLoad() {
        super.viewDidLoad()
        mapViewModel = MapViewModel()
        mapViewModel.requestLocationAuthorization()
        view.addSubview(mapView)
    }

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
