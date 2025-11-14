import SwiftUI
import SwiftData

struct ContactListView: View {
    @Environment(\.modelContext) private var context

    // Queries per category using SwiftData #Predicate
    @Query(filter: #Predicate<Contact> { contact in
        contact.category?.name == "Friend"
    }, sort: [SortDescriptor(\.name)])
    private var friendContacts: [Contact]


    @Query(filter: #Predicate<Contact> { contact in
        contact.category?.name == "Family"
    }, sort: [SortDescriptor(\.name)])
    private var familyContacts: [Contact]


    @Query(filter: #Predicate<Contact> { contact in
        contact.category?.name == "Work"
    }, sort: [SortDescriptor(\.name)])
    private var workContacts: [Contact]


    @Query(filter: #Predicate<Contact> { contact in
        contact.category?.name == "Other"
    }, sort: [SortDescriptor(\.name)])
    private var otherContacts: [Contact]


    var body: some View {
        ZStack {
                    LinearGradient(
                        gradient: Gradient(colors: [Color(white: 0.95), Color(red: 0.98, green: 0.96, blue: 0.93)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .ignoresSafeArea()                

            ScrollView {
                VStack(spacing: 20) {
                    // Each category section
                    if !familyContacts.isEmpty {
                        CategorySectionView(
                            categoryName: "Family",
                            contacts: familyContacts,
                            deleteContactAction: deleteContact
                        )
                    }

                    if !friendContacts.isEmpty {
                        CategorySectionView(
                            categoryName: "Friend",
                            contacts: friendContacts,
                            deleteContactAction: deleteContact
                        )
                    }

                    if !workContacts.isEmpty {
                        CategorySectionView(
                            categoryName: "Work",
                            contacts: workContacts,
                            deleteContactAction: deleteContact
                        )
                    }

                    if !otherContacts.isEmpty {
                        CategorySectionView(
                            categoryName: "Other",
                            contacts: otherContacts,
                            deleteContactAction: deleteContact
                        )
                    }
                }
                .padding()
            }
//            VStack {
//                            Spacer() // Pushes the image to the bottom
//                            Image("pigeon")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(height: 200) // Adjust size as needed
//                                .opacity(0.4) // Make it subtle so it doesn't distract from contacts
//                                .padding(.bottom, 20)
//                        }
        }
        .navigationTitle("Contacts")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    AddContactsView()
                } label: {
                    Label("Add", systemImage: "plus")
                        .font(.title3)
                        .foregroundStyle(.black)
                }
            }
        }
    }

    // Delete a single contact
    private func deleteContact(_ contact: Contact) {
        context.delete(contact)
        try? context.save()
    }
}
