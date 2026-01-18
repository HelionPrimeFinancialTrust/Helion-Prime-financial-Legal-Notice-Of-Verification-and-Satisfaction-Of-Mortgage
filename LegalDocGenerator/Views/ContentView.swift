//
//  ContentView.swift
//  LegalDocGenerator
//
//  Main app view
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var documentManager: DocumentManager
    @State private var showingDocumentSelector = false
    @State private var selectedDocument: LegalDocument?

    var body: some View {
        NavigationView {
            List {
                if documentManager.documents.isEmpty {
                    VStack(spacing: 20) {
                        Image(systemName: "doc.text.magnifyingglass")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                        Text("No Documents")
                            .font(.title2)
                            .foregroundColor(.gray)
                        Text("Create your first legal document")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                } else {
                    ForEach(documentManager.documents) { document in
                        NavigationLink(destination: DocumentEditorView(document: document)) {
                            DocumentRowView(document: document)
                        }
                    }
                    .onDelete(perform: deleteDocuments)
                }
            }
            .navigationTitle("Legal Documents")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingDocumentSelector = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingDocumentSelector) {
                DocumentSelectorView()
            }
        }
    }

    private func deleteDocuments(at offsets: IndexSet) {
        for index in offsets {
            let document = documentManager.documents[index]
            documentManager.deleteDocument(document)
        }
    }
}

struct DocumentRowView: View {
    let document: LegalDocument

    var body: some View {
        HStack {
            Image(systemName: document.documentType.icon)
                .font(.title2)
                .foregroundColor(.blue)
                .frame(width: 40)

            VStack(alignment: .leading, spacing: 4) {
                Text(document.title)
                    .font(.headline)
                Text(document.documentType.rawValue)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(document.documentId)
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                StatusBadge(status: document.status)
                Text(formatDate(document.createdDate))
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 4)
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }
}

struct StatusBadge: View {
    let status: LegalDocument.DocumentStatus

    var body: some View {
        Text(status.rawValue)
            .font(.caption)
            .padding(.horizontal, 8)
            .padding(.vertical, 2)
            .background(backgroundColor)
            .foregroundColor(.white)
            .cornerRadius(8)
    }

    private var backgroundColor: Color {
        switch status {
        case .draft: return .orange
        case .completed: return .green
        case .exported: return .blue
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(DocumentManager())
    }
}
