import Foundation
import CoreLocation
import Combine
import MapKit

@MainActor

final class MapViewModel:NSObject, CLLocationManagerDelegate {
    var locationMark: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.00, longitude: 0.00)
    var cancellables = Set<AnyCancellable>()
    private let locationManager = CLLocationManager()
    private var cancellablePipeline: AnyCancellable?
    var locationSubject = CurrentValueSubject<LocationData?, Never>(nil)
    var locationData: [LocatinInfo] = []
    var encountRepository: EncounterRepositoryProtocol?
    var isStartTouring: Bool = false
    let geocoder = CLGeocoder()
        super.init()
        locationManager.delegate = self
    }
    
    func requestLocationAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            requestLocationAuthorization()
        case .restricted, .denied:
            break
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
            break
        default:
            break
        }
    }
}
