//
//  LegalDocument.swift
//  LegalDocGenerator
//
//  Model representing a legal document with all its data
//

import Foundation

struct LegalDocument: Identifiable, Codable {
    let id: UUID
    let documentType: DocumentType
    var title: String
    var documentId: String
    var createdDate: Date
    var data: [String: String]
    var status: DocumentStatus

    init(documentType: DocumentType) {
        self.id = UUID()
        self.documentType = documentType
        self.title = documentType.rawValue
        self.documentId = Self.generateDocumentId(for: documentType)
        self.createdDate = Date()
        self.data = [:]
        self.status = .draft
    }

    enum DocumentStatus: String, Codable {
        case draft = "Draft"
        case completed = "Completed"
        case exported = "Exported"
    }

    static func generateDocumentId(for type: DocumentType) -> String {
        let prefix: String
        switch type {
        case .mortgageSatisfaction: prefix = "HSM"
        case .powerOfAttorney: prefix = "POA"
        case .nda: prefix = "NDA"
        case .employmentContract: prefix = "EMP"
        case .lease: prefix = "LSE"
        case .promissoryNote: prefix = "PRM"
        case .billOfSale: prefix = "BOS"
        case .lastWillTestament: prefix = "WIL"
        case .businessContract: prefix = "BUS"
        case .serviceAgreement: prefix = "SVC"
        }

        let year = Calendar.current.component(.year, from: Date())
        let random = String(format: "%06d", Int.random(in: 0...999999))
        return "\(prefix)-\(year)-\(random)"
    }

    func isComplete() -> Bool {
        let requiredFields = documentType.requiredFields
        for field in requiredFields {
            if data[field] == nil || data[field]?.isEmpty == true {
                return false
            }
        }
        return true
    }
}

// Make DocumentType Codable
extension DocumentType: Codable {}
