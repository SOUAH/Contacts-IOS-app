//
//  ContactsCassifierApp.swift
//  ContactsCassifier
//
//  Created by Souha Aouididi on 10/11/25.
//
//launch
import SwiftUI
import SwiftData

@main
struct ContactsClassifierApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [Contact.self, Category.self])
        }
    }
}

