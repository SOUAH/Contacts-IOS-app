//
//  AddContactsView.swift
//  ContactsCassifier
//
//  Created by Souha Aouididi on 10/11/25.


import SwiftUI
import SwiftData

struct AddContactsView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    // Assuming you have a Category model defined for this query to work
    @Query private var categories: [Category]
    @State private var name = ""
    @State private var phone = ""
    @State private var email = ""
    @State private var note = ""
    @State private var selectedCategory: Category? // Using Category model
    
    @State private var showInvalidPhoneAlert = false

    //Utility Function
    private var isSaveButtonDisabled: Bool {
        name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
        phone.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
        selectedCategory == nil
    }

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
                    TextField("Name", text: $name)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.words)
                    TextField("Phone", text: $phone)
                        .keyboardType(.numberPad)
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                    TextField("Note", text: $note)
                }

                Section("Category") {
                    Picker("Choose Category", selection: $selectedCategory) {
                        // Option to select no category (if desired)
                        Text("None").tag(nil as Category?)
                        ForEach(categories) { category in
                            Text(category.name).tag(Optional(category))
                        }
                    }
                }
                
            }
            .scrollContentBackground(.hidden) //Hide Form's default background
        }
        .navigationTitle("Add Contact")
        .toolbar {
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    saveContact()
                } label: {
                    Label("Save", systemImage: "checkmark")
                        .font(.title2)
                        .foregroundColor(.mint)
                }.disabled(isSaveButtonDisabled)
            }
            
        }
        .onAppear {
            seedDefaultCategoriesIfNeeded()
            // Try to set a default category (e.g., "Other") if one exists
            if selectedCategory == nil {
                selectedCategory = categories.first { $0.name == "Other" }
            }
        }
        .alert("Invalid phone number", isPresented: $showInvalidPhoneAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Phone number should only contain digits (0–9).")
        }
    }

    private func seedDefaultCategoriesIfNeeded() {
        // Ensure this only runs if the context has no categories yet
        if categories.isEmpty {
            let defaults = ["Family", "Friend", "Work", "Other"]
            for name in defaults {
                context.insert(Category(name: name))
            }
            try? context.save()
        }
    }

    private func isPhoneDigitsOnly(_ value: String) -> Bool {
        !value.isEmpty && value.range(of: "^[0-9]+$", options: .regularExpression) != nil
    }

    private func saveContact() {
        guard isPhoneDigitsOnly(phone) else {
            showInvalidPhoneAlert = true
            return
        }
        
        // Ensure a category is selected before saving
        guard let categoryToSave = selectedCategory else { return }

        let newContact = Contact(
            name: name,
            phone: phone,
            email: email.isEmpty ? nil : email,
            note: note.isEmpty ? nil : note,
            category: categoryToSave // Pass the Category model object
        )

        context.insert(newContact)
        try? context.save()
        dismiss()
    }
}


#Preview {
    AddContactsView()
        .modelContainer(for: [Contact.self, Category.self])
}
