//
//  ContactListView.swift
//  ContactsCassifier
//
//  Created by Souha Aouididi on 10/11/25.
//


import SwiftUI
import SwiftData

struct ContactsListView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: [SortDescriptor(\Category.createdAt)]) private var categories: [Category]

    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.yellow.opacity(0.2), Color.white]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {
                    ForEach(categories) { category in
                        // Get the contacts in this category
                        let contactsInCategory = category.contacts.sorted { $0.name < $1.name }

                        CategorySectionView(
                            categoryName: category.name,
                            contacts: contactsInCategory,
                            deleteContactAction: deleteContact
                        )
                    }
                }
                .padding()
            }

        }
        .navigationTitle("Contacts")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: AddContactsView()) {
                    Label("Add", systemImage: "plus.circle.fill")
                        .font(.title3)
                        .foregroundStyle(.black)
                }
            }
        }
    }

    private func deleteContact(_ contact: Contact) {
        context.delete(contact)
        try? context.save()
    }

    private func deleteCategory(_ category: Category) {
        context.delete(category)
        try? context.save()
    }
}
