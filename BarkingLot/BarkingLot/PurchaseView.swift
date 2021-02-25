//
//  PurchaseView.swift
//  BarkingLot
//
//  Created by Paul Hudson on 15/07/2020.
//

import SwiftUI
import UserNotifications
import StoreKit

struct PurchaseView: View {
    @EnvironmentObject var model: DataModel
    @State private var orderPlaced = false
    @State private var presentingAppStoreOverlay = false
    let store: Store
    let service: Service

    var body: some View {
        Form {
            Section {
                Text("Store: \(store.name)")
                Text("Address: \(store.address)")
                Text("Service: \(service.name)")
                Text("Price: \(service.formattedPrice)")
            }

            Section {
                (Text("Ready by: ") + Text(Date().addingTimeInterval(service.duration), style: .time))
                    .bold()
            }

            if orderPlaced {
                Text("Thank you!")
                    .font(.largeTitle)

                Text("See you soon!")
            } else {
                Section(footer:
                    model.canPurchase == false
                    ? AnyView(Text("Sorry, you need to be in or near this store to make a booking."))
                    : AnyView(EmptyView())
                ) {
                    Button("Reserve ") {
                        orderPlaced = true
                        presentingAppStoreOverlay = true
                        scheduleNotification()
                    }
                }
                .disabled(model.canPurchase == false)
            }
        }
        .navigationTitle("Confirmation")
        .appStoreOverlay(isPresented: $presentingAppStoreOverlay) {
            SKOverlay.AppClipConfiguration(position: .bottom)
        }
    }
    
    func scheduleNotification() {
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized || settings.authorizationStatus == .ephemeral {
                let content = UNMutableNotificationContent()
                content.title = "Come get your dog"
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                center.add(request)
            }
        }
    }
}

struct PurchaseView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseView(store: Store.example, service: Service.example)
    }
}
