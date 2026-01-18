//
//  NDATemplate.swift
//  LegalDocGenerator
//
//  Template for Non-Disclosure Agreement
//

import Foundation

struct NDATemplate: DocumentTemplate {
    func generateContent(data: [String: String], documentId: String) -> [WordDocumentGenerator.ContentSection] {
        var sections: [WordDocumentGenerator.ContentSection] = []

        sections.append(.init(text: "NON-DISCLOSURE AGREEMENT", isHeading: false, style: .centered))
        sections.append(.init(text: ""))

        sections.append(.init(text: "This Non-Disclosure Agreement (the \"Agreement\") is entered into as of \(data["effectiveDate"] ?? "[DATE]") by and between:", isHeading: false))
        sections.append(.init(text: ""))
        sections.append(.init(text: "Disclosing Party: \(data["disclosingParty"] ?? "[DISCLOSING PARTY]")"))
        sections.append(.init(text: "Receiving Party: \(data["receivingParty"] ?? "[RECEIVING PARTY]")"))
        sections.append(.init(text: ""))

        sections.append(.init(text: "1. PURPOSE", isHeading: true))
        sections.append(.init(text: "The parties wish to explore a business relationship related to: \(data["purpose"] ?? "[PURPOSE]"). In connection with such discussions, Disclosing Party may share certain confidential technical and business information that it desires Receiving Party to treat as confidential."))
        sections.append(.init(text: ""))

        sections.append(.init(text: "2. CONFIDENTIAL INFORMATION", isHeading: true))
        sections.append(.init(text: "\"Confidential Information\" means any information disclosed by Disclosing Party to Receiving Party, either directly or indirectly, in writing, orally, or by inspection of tangible objects, including without limitation documents, business plans, source code, software, documentation, financial information, and other proprietary information."))
        sections.append(.init(text: ""))

        sections.append(.init(text: "3. NON-DISCLOSURE AND NON-USE OBLIGATIONS", isHeading: true))
        sections.append(.init(text: "Receiving Party agrees to:"))
        sections.append(.init(text: "a) Hold and maintain the Confidential Information in strict confidence"))
        sections.append(.init(text: "b) Not disclose Confidential Information to third parties"))
        sections.append(.init(text: "c) Use Confidential Information solely for the Purpose stated above"))
        sections.append(.init(text: "d) Protect Confidential Information using the same degree of care it uses to protect its own confidential information, but with no less than reasonable care"))
        sections.append(.init(text: ""))

        sections.append(.init(text: "4. TERM", isHeading: true))
        sections.append(.init(text: "This Agreement shall remain in effect for \(data["term"] ?? "[TERM]") from the Effective Date, or until terminated by either party with 30 days written notice."))
        sections.append(.init(text: ""))

        sections.append(.init(text: "5. RETURN OF MATERIALS", isHeading: true))
        sections.append(.init(text: "Upon termination of this Agreement or upon request by Disclosing Party, Receiving Party shall promptly return all documents, materials, and other tangible items containing or representing Confidential Information."))
        sections.append(.init(text: ""))

        sections.append(.init(text: "6. GOVERNING LAW", isHeading: true))
        sections.append(.init(text: "This Agreement shall be governed by the laws of \(data["governingLaw"] ?? "[JURISDICTION]"), without regard to its conflict of laws provisions."))
        sections.append(.init(text: ""))

        sections.append(.init(text: "7. ENTIRE AGREEMENT", isHeading: true))
        sections.append(.init(text: "This Agreement constitutes the entire agreement between the parties concerning the subject matter hereof and supersedes all prior agreements and understandings."))
        sections.append(.init(text: ""))
        sections.append(.init(text: ""))

        sections.append(.init(text: "IN WITNESS WHEREOF, the parties have executed this Agreement as of the date first written above."))
        sections.append(.init(text: ""))
        sections.append(.init(text: ""))

        sections.append(.init(text: "DISCLOSING PARTY:", isHeading: false, style: .bold))
        sections.append(.init(text: "_________________________________"))
        sections.append(.init(text: "Name: \(data["disclosingParty"] ?? "")"))
        sections.append(.init(text: "Date: _____________"))
        sections.append(.init(text: ""))
        sections.append(.init(text: ""))

        sections.append(.init(text: "RECEIVING PARTY:", isHeading: false, style: .bold))
        sections.append(.init(text: "_________________________________"))
        sections.append(.init(text: "Name: \(data["receivingParty"] ?? "")"))
        sections.append(.init(text: "Date: _____________"))

        return sections
    }
}
