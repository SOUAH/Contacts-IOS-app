//
//  ContentCard.swift
//  ContactsCassifier
//
//  Created by Souha Aouididi on 11/11/25.
//

//Show a single contacts information name, phone... inside a layout
import Foundation
import SwiftUI


struct ContactCard: View {
    var contact: Contact

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(contact.name)
                .font(.headline)
                .foregroundColor(.primary)

            HStack {
                Label(contact.phone, systemImage: "phone.fill")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Spacer()

//                if let email = contact.email, !email.isEmpty {
//                    Image(systemName: "envelope.fill")
//                        .foregroundColor(.mint)
//                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.85))
                .shadow(color: .mint.opacity(0.1), radius: 4, x: 0, y: 2)
        )
    }
}

