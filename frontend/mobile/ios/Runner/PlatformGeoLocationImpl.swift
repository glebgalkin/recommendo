import Foundation
import CoreLocation

extension FlutterError: Error {}

class PlatformGeoLocationImpl: PlatformGeoLocation {
    private var locationManager: LocationManager
    init() {
        self.locationManager = LocationManager()
    }

  func getCoordinates(completion: @escaping (Result<CoordinatesMessage, Error>) -> Void) {
      self.locationManager.requestUserLocation { result in
        switch result {
        case .success(let coordinates):
            let message = CoordinatesMessage(lat: coordinates.0, lng: coordinates.1)
            completion(.success(message))
        case .failure(let error):
            var code = 520;
    
            if error is NSError {
                code = (error as NSError).code;
            }
            completion(.failure(FlutterError(code: String(code), message: "Location permission denied", details: error.localizedDescription)))
        }
      }
  }
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    private var locationManager: CLLocationManager?
    private var completion: ((Result<(Double, Double), Error>) -> Void)?

    override init() {
        super.init()
        self.locationManager = CLLocationManager()
        self.locationManager?.delegate = self
    }

    func requestUserLocation(completion: @escaping (Result<(Double, Double), Error>) -> Void) {
        if let previous = self.completion {
            let error = NSError(domain: "Location", code: 429, userInfo: [NSLocalizedDescriptionKey: "Dropped previous completion"])
            previous(.failure(error))
        }
        self.completion = completion
        let authorizationStatus: CLAuthorizationStatus?

        if #available(iOS 14, *) {
            authorizationStatus = self.locationManager?.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }

        switch authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            self.locationManager?.requestLocation()
        case .denied, .restricted:
            let error = NSError(domain: "Location", code: 403, userInfo: [NSLocalizedDescriptionKey: "Location permission denied"])
            self.completion?(.failure(error))
            self.completion = nil
        case .notDetermined:
            self.locationManager?.requestWhenInUseAuthorization()
        @unknown default:
            self.locationManager?.requestWhenInUseAuthorization()
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            self.locationManager?.requestLocation()
        case .denied, .restricted:
            let error = NSError(domain: "Location", code: 403, userInfo: [NSLocalizedDescriptionKey: "Location permission denied"])
            self.completion?(.failure(error))
            self.completion = nil
        case .notDetermined:
            break
        @unknown default:
            break
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = CLLocationManager.authorizationStatus()
        self.locationManager(manager, didChangeAuthorization: status)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.completion?(.success((location.coordinate.latitude, location.coordinate.longitude)))
            self.completion = nil
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.completion?(.failure(error))
        self.completion = nil
    }
}
