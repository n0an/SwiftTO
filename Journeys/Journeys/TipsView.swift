//
//  TipsView.swift
//  Journeys
//
//  Created by Paul Hudson on 06/07/2020.
//

import SwiftUI

struct Tip: Decodable, Identifiable {
    enum CodingKeys: CodingKey {
        case title, body
    }

    let id = UUID()
    let title: String
    let body: String
}

struct StructuredTip: Identifiable {
    let id = UUID()
    let content: String
    let children: [StructuredTip]?
}

struct TipsView: View {
    let tips = Bundle.main.decode([Tip].self, from: "tips.json")
    
    var structuredTips: [StructuredTip] {
        return self.tips.map {StructuredTip(content: $0.title, children: [StructuredTip(content: $0.body, children: nil)])}
    }

    var body: some View {
        
        List(structuredTips, children: \.children) { structuredTip in
            VStack {
                if structuredTip.children != nil {
                    Text(structuredTip.content)
                        .font(.headline)
                } else {
                    Text(structuredTip.content)
                }
            }
        }
        
//        List(tips) { tip in
//            VStack(alignment: .leading) {
//                Text(tip.title)
//                    .font(.headline)
//                Text(tip.body)
//            }
//            .padding(.vertical)
//        }
        .navigationTitle("Tips")
    }
}

struct TipsView_Previews: PreviewProvider {
    static var previews: some View {
        PicksView()
    }
}
