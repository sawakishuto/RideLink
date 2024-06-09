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

    func postEndTouring() {
        encountRepository?.postTouringEnd()
    }

    func postLocationInfo() {
        encountRepository?.postUserLocation(userLocInfo: locationData)
            .sink { completion in
                switch completion {
                case .failure(_):
                    print("print")
                    return
                case.finished:
                    print("print")
                    return
                }
            } receiveValue: { response in
                print(response)
            }
            .store(in: &cancellables)

    }

    func searchLocationFromName(destinationName: String) -> Future<CLLocationCoordinate2D, Error> {
        return Future { promise in
            self.geocoder.geocodeAddressString(destinationName) { placemarks, error in
                if let placemark = placemarks?.first, let location = placemark.location {
                    let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                    self.locationMark = coordinate // 位置情報を更新
                    promise(.success(coordinate)) // 成功時にpromiseを呼び出す
                } else if let error = error {
                    promise(.failure(error)) // エラーがある場合はfailureを呼び出す
                } else {
                    promise(.failure(error!)) // プレースマークが見つからない場合はエラーを呼び出す
                }
            }
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

    func createRoute(from sourceLocation: CLLocationCoordinate2D, to destinationLocation: CLLocationCoordinate2D, completion: @escaping (MKRoute?) -> Void) {
            let sourcePlaceMark = MKPlacemark(coordinate: sourceLocation)
            let destinationPlaceMark = MKPlacemark(coordinate: destinationLocation)

            let directionRequest = MKDirections.Request()
            directionRequest.source = MKMapItem(placemark: sourcePlaceMark)
            directionRequest.destination = MKMapItem(placemark: destinationPlaceMark)
            directionRequest.transportType = .automobile

            let directions = MKDirections(request: directionRequest)
            directions.calculate { (response, error) in
                guard let directionResponse = response else {
                    if let error = error {
                        print("Error getting directions: \(error.localizedDescription)")
                    }
                    completion(nil)
                    return
                }

                let route = directionResponse.routes.first
                completion(route)
            }
        }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if isStartTouring {
            let location = locations.first
            let latitude = location?.coordinate.latitude ?? 0.0
            let longitude = location?.coordinate.longitude ?? 0.0
            locationData.append(LocatinInfo(latitude: latitude, longitude: longitude))
        }
    }
}
