//
//  BarkingLotClipApp.swift
//  BarkingLotClip
//
//  Created by Anton Novoselov on 24.02.2021.
//

import AppClip
import SwiftUI
import MapKit

extension Array where Element == URLQueryItem {
    func value(for name: String) -> String? {
        first(where: {$0.name == name})?.value
    }
}

@main
struct BarkingLotClipApp: App {
    @StateObject var model = DataModel(canPurchase: false)

    var body: some Scene {
        WindowGroup {
            NavigationView {
                SelectStoreView()
            }
            .environmentObject(model)
            .onContinueUserActivity(NSUserActivityTypeBrowsingWeb, perform: handleActivity)
        }
    }
    
    func handleActivity(_ userActivity: NSUserActivity) {
        guard let url = userActivity.webpageURL else { return }
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return }
        guard let queryItems = components.queryItems else { return }
        
        if let storeID = queryItems.value(for: "store") {
            model.selectedStore = storeID
        }
        
        guard let payload = userActivity.appClipActivationPayload,
              let lat  = queryItems.value(for: "latitude"),
              let lon = queryItems.value(for: "longitude"),
              let latitude = Double(lat),
              let longitude = Double(lon) else { return }
        
        let region = CLCircularRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), radius: 1000, identifier: "location")
        
        payload.confirmAcquired(in: region) { inRegion, error in
            
            if inRegion {
                DispatchQueue.main.async {
                    model.canPurchase = true
                }
            }
        }
        
        DispatchQueue.main.async {
            model.canPurchase = true
        }
    }
}
