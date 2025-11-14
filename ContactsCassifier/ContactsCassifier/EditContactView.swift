
// EditContactsView.swift
// ContactsClassifier
//
// Created by Souha Aouididi on 10/11/25.
//


import SwiftUI
import SwiftData

struct EditContactView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @Bindable var contact: Contact
    @Query private var categories: [Category]
    @State private var showDelete = false
    @State private var selectedCategory: Category?

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(white: 0.95), Color(red: 0.98, green: 0.96, blue: 0.93)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            Form {
                Section("Contact Info") {
                    TextField("Name", text: $contact.name)
                    TextField("Phone", text: $contact.phone)
                        .keyboardType(.numberPad)
                    TextField("Email", text: Binding(
                        get: { contact.email ?? "" },
                        set: { contact.email = $0.isEmpty ? nil : $0 }
                    ))
                    TextField("Note", text: Binding(
                        get: { contact.note ?? "" },
                        set: { contact.note = $0.isEmpty ? nil : $0 }
                    ))
                }

                Section("Category") {
                    Picker("Choose Category", selection: $selectedCategory) {
                        ForEach(categories) { category in
                            Text(category.name).tag(Optional(category))
                        }
                    }
                    .onAppear {
                        //Initialize selectedCategory with the contact's current category
                        selectedCategory = contact.category
                    }
                }

                Section {
                    Button(role: .destructive) {
                        showDelete = true
                    } label: {
                        Text("Delete Contact")
                            .frame(maxWidth: .infinity)
                    }
                    .listRowBackground(Color.clear)
                    .confirmationDialog("Are you sure?", isPresented: $showDelete) {
                        Button("Delete", role: .destructive) {
                            context.delete(contact)
                            try? context.save()
                            dismiss()
                        }
                    }
                }
            }
            .scrollContentBackground(.hidden) // Hide default Form background
        }
        .navigationTitle("Edit Contact")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    saveAndDismiss()
                } label: {
                    Label("Save", systemImage: "checkmark")
                        .font(.title2)
                        .foregroundColor(.mint)
                }
            }
        }
    }
    
    private func saveAndDismiss() {
        contact.category = selectedCategory
        try? context.save()
        dismiss()
    }
}
