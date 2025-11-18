//
//  CategorySectionView.swift
//  ContactsCassifier
//
//  Created by Souha Aouididi on 11/11/25.
//

//It displays a collapsible section for one category (like “Family” or “Work”) showing all its contacts, with options to expand, edit, or delete contacts or the whole category

import SwiftUI

struct CategorySectionView: View {
    var categoryName: String
    var contacts: [Contact]
    var deleteContactAction: (Contact) -> Void

    @State private var isExpanded = true

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(categoryName)
                    .font(.headline)
                    .foregroundColor(.black)

                Spacer()

                Button {
                    withAnimation { isExpanded.toggle() }
                } label: {
                    Image(systemName: isExpanded ? "chevron.up.circle.fill" : "chevron.down.circle.fill").frame(width: 50, height: 50)
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal)

            if isExpanded {
                ForEach(contacts) { contact in
                    NavigationLink(destination: EditContactView(contact: contact)) {
                        ContactCard(contact: contact)
                    }
                    .buttonStyle(.plain)
                    .swipeActions {
                        Button(role: .destructive) {
                            deleteContactAction(contact)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
                .transition(.opacity)
            }
        }
        .padding(.vertical, 6)
    }
}





//#Preview {
//    NavigationStack {
//        CategorySectionView(
//            title: "Contacts",
//            contacts: [],
//            deleteCategoryAction: { },
//            deleteContactAction: { _ in }
//        )
//        .padding()
//    }
//    .modelContainer(for: Contact.self)
//}

