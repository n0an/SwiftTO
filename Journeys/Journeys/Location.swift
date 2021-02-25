//
//  Location.swift
//  Journeys
//
//  Created by Paul Hudson on 06/07/2020.
//

import Foundation
import CoreLocation

class Locations: ObservableObject {
    let places = Bundle.main.decode([Location].self, from: "locations.json")

    var primary: Location {
        places[0]
    }
}

struct Location: Decodable, Identifiable {
    var id: String {
        "\(name)-\(country)"
    }
    
    let name: String
    let country: String
    let description: String
    let more: String
    let location: Coordinate
    let heroPicture: String
    let pictures: [String]
    let advisory: String

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
    }

    static let example = Bundle.main.decode([Location].self, from: "locations.json")[0]
}

struct Coordinate: Decodable {
    var latitude: Double
    var longitude: Double
}
