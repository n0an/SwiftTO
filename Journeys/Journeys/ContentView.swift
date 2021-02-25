//
//  ContentView.swift
//  Journeys
//
//  Created by Paul Hudson on 06/07/2020.
//

import SwiftUI

// Your company has been asked to build a proof of concept for a travel company – if the prototype gets the green light then you'll be paid an absurd amount of money to build more or less the same thing, just with fewer bugs. (Probably)
// Your CTO put together the bare bones of the app, but it's down to you to fill it out with lots of SwiftUI code from iOS 14.

struct SidebarNavigation: View {
    @EnvironmentObject var locations: Locations

    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: LocationsView()) {
                    Text("Locations")
                }
                
                NavigationLink(destination: DiscoverView(location: locations.primary)) {
                    Text("Discover")
                }
                
                NavigationLink(destination: PicksView()) {
                    Text("Picks")
                }
                
                NavigationLink(destination: TipsView()) {
                    Text("Trips")
                }
            }
            .navigationTitle("Journeys")
            .listStyle(SidebarListStyle())
            
            LocationsView()
        }
    }
}

struct TabNavigation: View {
    @EnvironmentObject var locations: Locations

    var body: some View {
        TabView {
            NavigationView {
                LocationsView()
            }
            .tabItem {
                Image(systemName: "map.fill")
                    .imageScale(.large)
                Text("Map")
            }
            
            DiscoverView(location: locations.primary)
                .tabItem {
                    Image(systemName: "airplane.circle.fill")
                        .imageScale(.large)
                    Text("Discover")
                }

            NavigationView {
                PicksView()
            }
            .tabItem {
                Image(systemName: "star.fill")
                    .imageScale(.large)
                Text("Picks")
            }

            NavigationView {
                TipsView()
            }
            .tabItem {
                Image(systemName: "list.bullet")
                    .imageScale(.large)
                Text("Tips")
            }
        }
    }
    
}

struct ContentView: View {
    @EnvironmentObject var locations: Locations
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
//    var body: some View {
//        if sizeClass == .compact {
//            TabNavigation()
//        } else {
//            SidebarNavigation()
//        }
//    }

    var body: some View {
        
        if sizeClass == .compact {
            TabNavigation()
        } else {
            SidebarNavigation()
        }
        
//        TabView {
//            NavigationView {
//                LocationsView()
//            }
//            .tabItem {
//                Image(systemName: "map.fill")
//                    .imageScale(.large)
//                Text("Map")
//            }
//
//            DiscoverView(location: locations.primary)
//                .tabItem {
//                    Image(systemName: "airplane.circle.fill")
//                        .imageScale(.large)
//                    Text("Discover")
//                }
//
//            NavigationView {
//                PicksView()
//            }
//            .tabItem {
//                Image(systemName: "star.fill")
//                    .imageScale(.large)
//                Text("Picks")
//            }
//
//            NavigationView {
//                TipsView()
//            }
//            .tabItem {
//                Image(systemName: "list.bullet")
//                    .imageScale(.large)
//                Text("Tips")
//            }
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Locations())
        
        
    }
}
