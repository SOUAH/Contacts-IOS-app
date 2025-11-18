//
//  CategoryModel.swift
//  ContactsCassifier
//
//  Created by Souha Aouididi on 11/11/25.
//

//defineing the data model for contact groups (like Family, Friend, Work, Other) and links each category to its contacts through a one-to-many relationship
import Foundation
import SwiftData

@Model
final class Category: Identifiable {
    var id: UUID
    var name: String
    var contacts: [Contact] = []
    var createdAt: Date

    init(id: UUID = UUID(), name: String, createdAt: Date = Date()) {
        self.id = id
        self.name = name
        self.createdAt = createdAt
    }
}


