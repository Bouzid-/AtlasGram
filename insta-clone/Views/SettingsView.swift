//
//  Created by Amine Bouzid on 27/10/2025.
//  Copyright (c) 2025 Atlas Instagram. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showingClearConfirmation = false
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Data Management")) {
                    Button(action: {
                        PersistenceManager.shared.printStoredData()
                    }) {
                        HStack {
                            Image(systemName: "info.circle")
                                .foregroundColor(.blue)
                            Text("View Stored Data")
                                .foregroundColor(.primary)
                        }
                    }
                    
                    Button(action: {
                        showingClearConfirmation = true
                    }) {
                        HStack {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                            Text("Clear All Likes & Bookmarks")
                                .foregroundColor(.red)
                        }
                    }
                }
                
                Section(header: Text("Persistence Info")) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Data Storage")
                            .font(.headline)
                        Text("Your likes and bookmarks are automatically saved to your device and will persist between app launches.")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 4)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Privacy")
                            .font(.headline)
                        Text("All data is stored locally on your device only. No information is sent to external servers.")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("Settings")
            .navigationBarItems(
                trailing: Button("Done") {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
        .alert("Clear All Data", isPresented: $showingClearConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Clear", role: .destructive) {
                PersistenceManager.shared.clearAllData()
                print("🗑️ All persistence data cleared")
            }
        } message: {
            Text("This will remove all your saved likes and bookmarks permanently.")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}