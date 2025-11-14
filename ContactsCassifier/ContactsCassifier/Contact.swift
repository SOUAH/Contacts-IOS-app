//
//  ContactsData.swift
//  ContactsCassifier
//
//  Created by Souha Aouididi on 10/11/25.
//

import Foundation
import SwiftData

@Model
final class Contact: Identifiable {
    var id: UUID
    var name: String
    var phone: String
    var email: String?
    var note: String?
    var createdAt: Date
    var category: Category?  // Relationship is automatically inferred, I tried other methods tho
    var birthday: Date?
    
    init(
        id: UUID = UUID(),
        name: String,
        phone: String,
        email: String? = nil,
        note: String? = nil,
        category: Category? = nil,
        createdAt: Date = Date(),
        birthday: Date? = nil
    ) {
        self.id = id
        self.name = name
        self.phone = phone
        self.email = email
        self.note = note
        self.category = category
        self.createdAt = createdAt
        self.birthday = birthday
    }
}

