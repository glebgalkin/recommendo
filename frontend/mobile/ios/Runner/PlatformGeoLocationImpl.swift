import Foundation

extension FlutterError: Error {}

class PlatformGeoLocationImpl: PlatformGeoLocation {
  func getHostLanguage() throws -> String {
    return "Swift"
  }


  func getCoordinates(completion: @escaping (Result<CoordinatesMessage, Error>) -> Void) {
    let sampleLocation = CoordinatesMessage(lat: 1.1, lng: 2.2);
    completion(.success(sampleLocation))
  }
}
