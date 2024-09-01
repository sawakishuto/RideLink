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
        mapView.snp.makeConstraints {
            if let superview = mapView.superview {
                $0.edges.equalTo(superview.safeAreaLayoutGuide)
            }
        }
        
        view.addSubview(touringButton)
        touringButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-40)
        }
        
        view.addSubview(currentLocationButton)
        currentLocationButton.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-150)
        }

        view.isUserInteractionEnabled = true
        
    }

    private lazy var mapView: MKMapView = {
        let map = MKMapView()
        var region: MKCoordinateRegion = map.region
        region.center = map.userLocation.coordinate
        region.span.latitudeDelta = 0.001
        region.span.longitudeDelta = 0.001
        map.setRegion(region, animated: true)
        map.mapType = .standard
        map.userTrackingMode = .followWithHeading
        map.frame = CGRect(x: 10, y: 10, width: 400, height: view.frame.height)
        return map
    }()
    
    private lazy var touringButton: TouringButton = {
        let button = TouringButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        button.addTarget(self, action: #selector(tapStartButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.9
        button.layer.shadowRadius = 4
        return button
    }()
    
    
    private var currentLocationButton: CurrentLocationButton = {
        let button = CurrentLocationButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        button.addTarget(self, action: #selector(focusCurrentLocation), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 4
        return button
    }()
}

extension MapViewController {

    @objc private func tapStartButton() {
        if !mapViewModel.isStartTouring {
            let vc = ModalViewController { 
                self.toggleIsStart()
                self.dismiss(animated: true)
                print("投げました")
                self.mapViewModel.postTouringCondition(destinationName: self.destinationName, touringComment: self.touringComment)
            } destinationNameOnChanged: { destination in
                print(destination)
                self.destinationName = destination
                print(self.destinationName)
            } touringCommentOnChanged: { comment in
                print(comment)
                self.touringComment = comment
                print(self.touringComment)
            }
            if let sheet = vc.sheetPresentationController {
                // ここで指定したサイズで表示される
                sheet.detents = [.large()]
            }
            present(vc, animated: true, completion: nil)
        } else {
            toggleIsStart()
        }
    }

    @objc func focusCurrentLocation() {
        if let userLocation = mapView.userLocation.location {
            let region = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 300, longitudinalMeters: 300)
            mapView.setRegion(region, animated: true)
            self.mapView.userTrackingMode = .followWithHeading
        } else {
            self.mapView.userTrackingMode = .followWithHeading
        }

    }
    
     func toggleIsStart() {
        self.mapViewModel.isStartTouring.toggle()
        touringButton.isStartTouring.toggle()
        print(mapViewModel.isStartTouring)
        if mapViewModel.isStartTouring {
            createRoot()
            self.mapView.tintColor = UIColor(red: 14/255.0, green: 124/255.0, blue: 100/255.0, alpha: 1.0)
        } else {
            mapView.overlays.forEach {
                if let overlay = $0 as? MKPolyline {
                    mapView.removeOverlay(overlay)
                    mapView.tintColor = .blue
                }
            }
            mapViewModel.postEndTouring()
        }
        
    }
    
    func createAnnotations(location: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        self.mapView.addAnnotation(annotation)
    }
    
    func createRoot() {
        let userLocation = mapView.userLocation.coordinate

            print(self.destinationName)

            self.mapViewModel.searchLocationFromName(destinationName: self.destinationName)
            .sink { response in
                switch response {
                case .finished:
                    print(self.mapViewModel.locationMark)
                    print("終わり")
                    return
                case .failure(let error):
                    print("\(error)")
                    return
                }
            } receiveValue: { [self] location in
                print(location)
                self.mapViewModel.createRoute(from: userLocation, to: location) { route in
                    if let route = route {
                        self.mapView.addOverlay(route.polyline, level: .aboveRoads)
                        self.mapView.setRegion(MKCoordinateRegion(route.polyline.boundingMapRect), animated: true)
                    }
                }
            }.store(in: &mapViewModel.cancellables) 
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = .blue
            renderer.lineWidth = 3
            return renderer
        }
        return MKOverlayRenderer()
    }
}

