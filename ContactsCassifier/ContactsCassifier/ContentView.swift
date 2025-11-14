//
//  ContentView.swift
//  ContactsCassifier
//
//  Created by Souha Aouididi on 10/11/25.
//


import SwiftData
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ContactListView()
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Contact.self, Category.self])
}

