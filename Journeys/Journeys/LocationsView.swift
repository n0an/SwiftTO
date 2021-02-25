//
//  LocationsView.swift
//  Journeys
//
//  Created by Anton Novoselov on 24.02.2021.
//

import MapKit
import SwiftUI


struct LocationsView: View {
    @EnvironmentObject var locations: Locations
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: self.locations.places) { location in
            MapAnnotation(coordinate: location.coordinate, anchorPoint: CGPoint(x: 0.5, y: 1)) {
                
                NavigationLink(destination: DiscoverView(location: location)) {
                    
                    Image(location.country)
                        .resizable()
                        .frame(width: 80, height: 40)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.blue, lineWidth: 4)
                        )
                }
            }
        }
        .navigationTitle("Vacation Map")
    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LocationsView()
        }
        .environmentObject(Locations())
    }
}
