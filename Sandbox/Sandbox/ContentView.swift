//
//  ContentView.swift
//  Sandbox
//
//  Created by Anton Novoselov on 22.02.2021.
//

import SwiftUI
import MapKit

struct City: Identifiable {
    var id: String { name }
    let name: String
    let location: CLLocationCoordinate2D
    static let london = City(name: "London", location: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275))
    static let paris = City(name: "Paris", location: CLLocationCoordinate2D(latitude: 48.864716, longitude: 2.349014))
}

struct Person: Identifiable {
    let id = UUID()
    var name: String
    var children: [Person]?
}

struct HomeView: View {
    var body: some View {
        Text("Home")
    }
}

struct StoreView: View {
    var body: some View {
        Text("Store")
    }
}

struct AccountView: View {
    var body: some View {
        Text("Account")
    }
}

struct SidebarNavigation: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: HomeView()) {
                    Text("Home")
                }
                
                NavigationLink(destination: StoreView()) {
                    Text("Store")
                }
                
                NavigationLink(destination: AccountView()) {
                    Text("Account")
                }
            }
            .listStyle(SidebarListStyle())
            
            HomeView()
        }
    }
}

struct TabNavigation: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            StoreView()
                .tabItem {
                    Image(systemName: "cart.fill")
                    Text("Store")
                }
            
            AccountView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Account")
                }
        }
    }
}

extension AnyTransition {
    struct NoneModifier: ViewModifier {
        func body(content: Content) -> some View { content }
    }
    static var none: AnyTransition {
        AnyTransition.modifier(active: NoneModifier(), identity: NoneModifier())
    }
}

struct ContentView: View {
    let countries = Bundle.main.decode([String].self, from: "countries.json")

    // MARK: - Horizontal Vertical transition
    /*
    @State private var isVertical = false
    @Namespace var animation
    @State private var names = ["Chidi", "Eleanor", "Jason", "Tahani"]
    
    var body: some View {
        if isVertical {
            VStack(spacing: 20) {
                ForEach(names, id: \.self) { name in
                    Text(name)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .matchedGeometryEffect(id: name, in: animation)
                }
            }
            .transition(.none)
            .onTapGesture {
                withAnimation {
                    isVertical.toggle()
                }
            }
        } else {
            HStack(spacing: 20) {
                ForEach(names, id: \.self) { name in
                    Text(name)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .matchedGeometryEffect(id: name, in: animation)
                }
            }
            .transition(.none)
            .onTapGesture {
                withAnimation {
                    isVertical.toggle()
                }
            }
        }
    }
    */

    // -------------------------------------
    // MARK: - Sidebar + TabBar
    /*
    @Environment(\.horizontalSizeClass) var sizeClass

    var body: some View {
        if sizeClass == .compact {
            TabNavigation()
        } else {
            SidebarNavigation()
        }
    }
    */

    // -------------------------------------
    // MARK: - Parent-children Lists
    /*
    var people: [Person] {
        let sophie = Person(name: "Sophie")
        let lottie = Person(name: "Lottie")
        let john = Person(name: "John")
        let paul = Person(name: "Paul", children: [sophie, lottie])
        let andrew = Person(name: "Andrew", children: [john])
        let terry = Person(name: "Terry", children: [paul, andrew])
        return [terry]
    }

    var body: some View {
        List(people, children: \.children) { person in
            Image(systemName: "person.circle")
            Text(person.name)
        }
    }
    */

    // -------------------------------------
    // MARK: - Map Annotations
    /*
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))

    let annotations = [City.london, City.paris]

    var body: some View {
        Map(coordinateRegion: $region, annotationItems: annotations) { annotation in
//            MapPin(coordinate: annotation.location)
//            MapMarker(coordinate: annotation.location, tint: .red)

//            MapAnnotation(coordinate: annotation.location) {
//                Circle()
//                    .stroke(Color.red, lineWidth: 4)
//                    .frame(width: 50, height: 50)
//            }

            MapAnnotation(coordinate: annotation.location, anchorPoint: CGPoint(x: 0.5, y: 1)) {
                Image(systemName: "mappin")
                    .imageScale(.large)
                    .foregroundColor(.red)
            }
        }
    }
    */

    // -------------------------------------
    // MARK: - Grids
    /*
    let layout = [
        GridItem(.adaptive(minimum: 100)),
        GridItem(.fixed(50)),
        GridItem(.adaptive(minimum: 100)),
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: layout, spacing: 50, pinnedViews: .sectionHeaders) {
                Section(header:
                    Text("meh")
                ) {
                    ForEach(1..<100) { i in
                        RoundedRectangle(cornerRadius: 40)
                            .fill(Color.random())
                            .frame(height: 200)
                    }
                }

            }
        }
    }
    */

    // -------------------------------------
    // MARK: - Pages using TabView
    /*
    var body: some View {
        ScrollView {
            TabView {
                ForEach(1...8, id: \.self) { i in
                    Image("photo\(i)")
                        .resizable()
                        .scaledToFit()
                        .tabItem {
                            Image(systemName: "\(i).circle")
                        }
                }
            }
            .frame(height: 350)
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        }
        .onAppear {
            UIPageControl.appearance().currentPageIndicatorTintColor  = .black
        }
    }

//    var body: some View {
//
//        ScrollView {
//            TabView {
//                ForEach(1...8, id: \.self) { i in
//                    GeometryReader { geo in
//                        Image("photo\(i)")
//                            .resizable()
//                            .scaledToFit()
//                            .tabItem {
//                                Image(systemName: "\(i).circle")
//                            }
//                            .frame(maxWidth: geo.size.width)
//                    }
//
//                }
//            }
//            .frame(height: 350)
//            .tabViewStyle(PageTabViewStyle())
//            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
//        }
//        .onAppear {
//            UIPageControl.appearance().currentPageIndicatorTintColor  = .black
//        }
//    }

    */
    
    // -------------------------------------
    // MARK: - Disclosure Group
    @State private var disclosureShow = false
    var body: some View {
        VStack {
            DisclosureGroup("Show saying", isExpanded: $disclosureShow) {
                Text("Lorem ipsum <--> Lorem ipsum <--> Lorem ipsum")
            }
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation {
                    disclosureShow.toggle()
                }
            }
            
            Spacer()
        }
        .padding()
        
    }
    
    // -------------------------------------
    // MARK: - Map
    /*
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 35.689722, longitude: 139.692222), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    var body: some View {
        VStack {
            Map(coordinateRegion: $region)
            Text("\(region.center.latitude), \(region.center.longitude)")
        }
    }
    */
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
