//
//  DocumentManager.swift
//  LegalDocGenerator
//
//  Manages document creation, storage, and retrieval
//

import Foundation
import Combine

class DocumentManager: ObservableObject {
    @Published var documents: [LegalDocument] = []
    @Published var currentDocument: LegalDocument?

    private let documentsKey = "SavedDocuments"

    init() {
        loadDocuments()
    }

    // MARK: - Document Management

    func createDocument(type: DocumentType) -> LegalDocument {
        let document = LegalDocument(documentType: type)
        documents.append(document)
        saveDocuments()
        return document
    }

    func updateDocument(_ document: LegalDocument) {
        if let index = documents.firstIndex(where: { $0.id == document.id }) {
            documents[index] = document
            saveDocuments()
        }
    }

    func deleteDocument(_ document: LegalDocument) {
        documents.removeAll { $0.id == document.id }
        saveDocuments()
    }

    func duplicateDocument(_ document: LegalDocument) {
        var newDocument = LegalDocument(documentType: document.documentType)
        newDocument.data = document.data
        newDocument.title = "\(document.title) (Copy)"
        documents.append(newDocument)
        saveDocuments()
    }

    // MARK: - Persistence

    private func saveDocuments() {
        if let encoded = try? JSONEncoder().encode(documents) {
            UserDefaults.standard.set(encoded, forKey: documentsKey)
        }
    }

    private func loadDocuments() {
        if let data = UserDefaults.standard.data(forKey: documentsKey),
           let decoded = try? JSONDecoder().decode([LegalDocument].self, from: data) {
            documents = decoded
        }
    }

    // MARK: - Export

    func exportDocument(_ document: LegalDocument, format: ExportFormat) -> URL? {
        switch format {
        case .word:
            return WordDocumentGenerator.shared.generateDocument(document)
        case .pdf:
            return PDFDocumentGenerator.shared.generateDocument(document)
        case .text:
            return TextDocumentGenerator.shared.generateDocument(document)
        }
    }

    enum ExportFormat {
        case word
        case pdf
        case text
    }
}
