//
//  PicksView.swift
//  Journeys
//
//  Created by Paul Hudson on 06/07/2020.
//

import SwiftUI

struct Place: View {
    let location: Location
    
    var body: some View {
        VStack {
            Image(location.country)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Text(location.name)
                .font(.title3)
                .multilineTextAlignment(.center)
            
            Text(location.country)
                .foregroundColor(.secondary)
                .font(.subheadline)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.white)
        )
        .shadow(color: .black.opacity(0.2), radius: 10)
        .padding()
    }
}

struct PicksView: View {
    @EnvironmentObject var locations: Locations
    
    let columns = [
        GridItem(.adaptive(minimum: 180))
    ]

    var body: some View {
        
        ScrollView {
            TabView {
                ForEach(1..<9, id: \.self) { i in
                    Image("photo\(i)")
                        .resizable()
                        .scaledToFill()
                        .clipped()
                }
            }
            .frame(height: 300)
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            
            LazyVGrid(columns: columns, alignment: .center, spacing: 0) {
                ForEach(self.locations.places) { place in
                    
                    NavigationLink(
                        destination: DiscoverView(location: place)) {
                        
                        Place(location: place)
                    }
                }
                
            }
            
            
//            LazyVGrid(columns: layout, spacing: 20) {
//                ForEach(self.locations.places) { place in
//
//                    VStack {
//                        Image(place.country)
//                            .padding()
//                        Text(place.name)
//                            .font(.headline)
//                            .fontWeight(.bold)
//                        Image(place.heroPicture)
//                    }
//
//                    .background(Color.gray.opacity(0.2))
//                    .clipShape(RoundedRectangle(cornerRadius: 10))
//
//                }
//
//            }
        }
        .navigationTitle("Our Top Picks")
    }
}

struct PicksView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PicksView()
        }
        .environmentObject(Locations())
    }
}
