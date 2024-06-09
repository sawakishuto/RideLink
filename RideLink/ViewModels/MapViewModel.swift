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


    init(encountRepository: EncounterRepositoryProtocol) {
        self.encountRepository = encountRepository
        super.init()
        locationManager.delegate = self

        cancellablePipeline = Timer
            .publish(every: 10, on: .main, in: .common)
            .autoconnect()
            .sink(receiveValue: { [unowned self] _ in
                if isStartTouring {
                    postLocationInfo()
                }

            })
    }
    
    func requestLocationAuthorization() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.distanceFilter = 40
    }

    func postTouringCondition(destinationName: String, touringComment: String) {
        let touringCondition = TouringInfoModel(destinationName: destinationName, touringComment: touringComment)
        encountRepository?.postTouringCondition(touringCondition: touringCondition)
    }
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
