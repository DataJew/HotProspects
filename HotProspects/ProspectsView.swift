//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Matthew Garlington on 3/19/21.
//

import SwiftUI

struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    @EnvironmentObject var prospects: Prospects
    let filter: FilterType
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted People"
        case .uncontacted:
            return "Uncontacted People"
        }
    }
    
    var body: some View {
        NavigationView {
            Text("People: \(prospects.people.count)")
                .navigationTitle(title)
                .navigationBarItems(trailing: Button(action: {
                    let prospect = Prospect()
                    prospect.name = "Matthew Garlington"
                    prospect.emailAddress = "SOMatthewG@gmail.com"
                    self.prospects.people.append(prospect)
                }, label: {
                    Image(systemName: "qrcode.viewfinder")
                    Text("Scan")
                }))
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
    }
}
