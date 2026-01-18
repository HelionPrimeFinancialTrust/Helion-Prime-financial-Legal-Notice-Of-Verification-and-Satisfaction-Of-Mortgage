//
//  DocumentEditorView.swift
//  LegalDocGenerator
//
//  View for editing document data and exporting
//

import SwiftUI

struct DocumentEditorView: View {
    @EnvironmentObject var documentManager: DocumentManager
    @Environment(\.dismiss) var dismiss
    @State private var document: LegalDocument
    @State private var showingExportSheet = false
    @State private var showingShareSheet = false
    @State private var exportedURL: URL?

    init(document: LegalDocument) {
        _document = State(initialValue: document)
    }

    var body: some View {
        Form {
            Section(header: Text("Document Information")) {
                TextField("Document Title", text: $document.title)
                Text("ID: \(document.documentId)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Section(header: Text("Required Fields")) {
                ForEach(document.documentType.requiredFields, id: \.self) { field in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(field.humanReadable())
                            .font(.caption)
                            .foregroundColor(.gray)
                        TextField(field.humanReadable(), text: binding(for: field))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                }
            }

            Section(header: Text("Document Status")) {
                HStack {
                    Text("Status:")
                    Spacer()
                    StatusBadge(status: document.status)
                }

                if document.isComplete() {
                    Text("✓ All required fields completed")
                        .font(.caption)
                        .foregroundColor(.green)
                } else {
                    Text("⚠️ Please complete all required fields")
                        .font(.caption)
                        .foregroundColor(.orange)
                }
            }

            if document.isComplete() {
                Section(header: Text("Export Options")) {
                    Button(action: { exportDocument(format: .word) }) {
                        HStack {
                            Image(systemName: "doc.text")
                            Text("Export as Word Document (.docx)")
                            Spacer()
                            Image(systemName: "arrow.down.doc")
                        }
                    }

                    Button(action: { exportDocument(format: .pdf) }) {
                        HStack {
                            Image(systemName: "doc.richtext")
                            Text("Export as PDF")
                            Spacer()
                            Image(systemName: "arrow.down.doc")
                        }
                    }

                    Button(action: { exportDocument(format: .text) }) {
                        HStack {
                            Image(systemName: "doc.plaintext")
                            Text("Export as Text File (.txt)")
                            Spacer()
                            Image(systemName: "arrow.down.doc")
                        }
                    }
                }
            }

            Section {
                Button(action: { previewDocument() }) {
                    HStack {
                        Image(systemName: "eye")
                        Text("Preview Document")
                        Spacer()
                    }
                }

                Button(role: .destructive, action: { deleteDocument() }) {
                    HStack {
                        Image(systemName: "trash")
                        Text("Delete Document")
                    }
                }
            }
        }
        .navigationTitle(document.documentType.rawValue)
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: document) { newValue in
            documentManager.updateDocument(newValue)
        }
        .sheet(isPresented: $showingShareSheet) {
            if let url = exportedURL {
                ShareSheet(items: [url])
            }
        }
    }

    private func binding(for field: String) -> Binding<String> {
        Binding(
            get: { document.data[field] ?? "" },
            set: { document.data[field] = $0 }
        )
    }

    private func exportDocument(format: DocumentManager.ExportFormat) {
        if let url = documentManager.exportDocument(document, format: format) {
            exportedURL = url
            var updatedDoc = document
            updatedDoc.status = .exported
            document = updatedDoc
            documentManager.updateDocument(updatedDoc)
            showingShareSheet = true
        }
    }

    private func previewDocument() {
        // TODO: Implement preview
    }

    private func deleteDocument() {
        documentManager.deleteDocument(document)
        dismiss()
    }
}

// Helper extension
extension String {
    func humanReadable() -> String {
        // Convert camelCase to Title Case
        let result = self.replacingOccurrences(of: "([a-z])([A-Z])",
                                                with: "$1 $2",
                                                options: .regularExpression)
        return result.prefix(1).uppercased() + result.dropFirst()
    }
}

// Share Sheet for iOS
struct ShareSheet: UIViewControllerRepresentable {
    let items: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: items, applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

struct DocumentEditorView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DocumentEditorView(document: LegalDocument(documentType: .mortgageSatisfaction))
                .environmentObject(DocumentManager())
        }
    }
}
