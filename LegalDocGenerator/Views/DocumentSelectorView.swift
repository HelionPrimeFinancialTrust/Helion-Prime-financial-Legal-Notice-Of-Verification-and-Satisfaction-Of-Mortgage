//
//  DocumentSelectorView.swift
//  LegalDocGenerator
//
//  View for selecting document type to create
//

import SwiftUI

struct DocumentSelectorView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var documentManager: DocumentManager
    @State private var selectedType: DocumentType?
    @State private var navigateToEditor = false

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Text("Choose a Document Type")
                        .font(.title2)
                        .bold()
                        .padding(.top)

                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(DocumentType.allCases) { type in
                            DocumentTypeCard(type: type)
                                .onTapGesture {
                                    createDocument(type: type)
                                }
                        }
                    }
                    .padding()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }

    private func createDocument(type: DocumentType) {
        let document = documentManager.createDocument(type: type)
        dismiss()
    }
}

struct DocumentTypeCard: View {
    let type: DocumentType

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: type.icon)
                .font(.system(size: 40))
                .foregroundColor(.blue)

            Text(type.rawValue)
                .font(.headline)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)

            Text(type.description)
                .font(.caption)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .lineLimit(3)
        }
        .frame(height: 180)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

struct DocumentSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        DocumentSelectorView()
            .environmentObject(DocumentManager())
    }
}
