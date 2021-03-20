//
//  Prospect.swift
//  HotProspects
//
//  Created by Matthew Garlington on 3/19/21.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    // Adding a filePrivate set allows only one view to write
    // and other views only to read in order for other views
    // not to have conflicting Booleans if the user is
    // contacted
    fileprivate(set) var isContacted = false
}

class Prospects: ObservableObject {
    // Adding a private set helps lock down the code
    // in order to only be used by the class writing
    // the data to be saved 
    @Published private(set) var people: [Prospect]
    static let saveKey = "SavedData"
    
    init() {
        // Add the data to be saved to UserDefaults
        if let data = UserDefaults.standard.data(forKey: Self.saveKey) {
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
                self.people = decoded
                return
            }
        }
        self.people = []
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(people) {
            UserDefaults.standard.set(encoded, forKey: Self.saveKey)
        }
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
}
