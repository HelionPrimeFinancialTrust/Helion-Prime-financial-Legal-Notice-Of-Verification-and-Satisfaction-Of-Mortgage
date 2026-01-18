//
//  MortgageSatisfactionTemplate.swift
//  LegalDocGenerator
//
//  Template for Mortgage Satisfaction Notice
//

import Foundation

struct MortgageSatisfactionTemplate: DocumentTemplate {
    func generateContent(data: [String: String], documentId: String) -> [WordDocumentGenerator.ContentSection] {
        var sections: [WordDocumentGenerator.ContentSection] = []

        // Header
        sections.append(.init(text: "PUBLIC NOTICE", isHeading: false, style: .centered))
        sections.append(.init(text: "Satisfaction and Verification of Mortgage", isHeading: false, style: .bold))
        sections.append(.init(text: ""))

        // Section I: Mortgage Information
        sections.append(.init(text: "I. MORTGAGE INFORMATION", isHeading: true))
        sections.append(.init(text: "Original Mortgage Date: \(data["mortgageDate"] ?? "")"))
        sections.append(.init(text: "Mortgage Reference Number: \(data["mortgageRefNumber"] ?? "")"))
        sections.append(.init(text: "Recording Office: \(data["recordingOffice"] ?? "")"))
        sections.append(.init(text: ""))

        // Section II: Property Information
        sections.append(.init(text: "II. PROPERTY INFORMATION", isHeading: true))
        sections.append(.init(text: "Property Address: \(data["propertyAddress"] ?? "")"))
        sections.append(.init(text: "City, State, ZIP: \(data["cityStateZip"] ?? "")"))
        sections.append(.init(text: "Legal Description: \(data["legalDescription"] ?? "")"))
        sections.append(.init(text: ""))

        // Section III: Parties
        sections.append(.init(text: "III. PARTIES", isHeading: true))
        sections.append(.init(text: "Original Borrower(s): \(data["borrowerName"] ?? "")"))
        sections.append(.init(text: "Original Lender: \(data["lenderName"] ?? "")"))
        sections.append(.init(text: "Current Mortgagee: \(data["currentMortgagee"] ?? "Helion Prime Financial Trust")"))
        sections.append(.init(text: ""))

        // Section IV: Satisfaction Details
        sections.append(.init(text: "IV. SATISFACTION DETAILS", isHeading: true))
        sections.append(.init(text: "Original Loan Amount: \(data["loanAmount"] ?? "")"))
        sections.append(.init(text: "Satisfaction Date: \(data["satisfactionDate"] ?? "")"))
        sections.append(.init(text: "Final Payment Date: \(data["finalPaymentDate"] ?? "")"))
        sections.append(.init(text: ""))

        // Notice Body
        sections.append(.init(text: "NOTICE IS HEREBY GIVEN", isHeading: false, style: .bold))
        sections.append(.init(text: "That the mortgage described above, originally executed by \(data["borrowerName"] ?? "[BORROWER]") in favor of \(data["lenderName"] ?? "[LENDER]"), has been FULLY SATISFIED and PAID IN FULL."))
        sections.append(.init(text: ""))
        sections.append(.init(text: "The undersigned, \(data["currentMortgagee"] ?? "Helion Prime Financial Trust"), as the current holder and mortgagee of the aforementioned mortgage, hereby certifies and verifies that all obligations under said mortgage have been completely satisfied, and the lien created by said mortgage is hereby released and discharged."))
        sections.append(.init(text: ""))

        // Certification
        sections.append(.init(text: "V. CERTIFICATION AND VERIFICATION", isHeading: true))
        sections.append(.init(text: "The undersigned hereby certifies under penalty of perjury that the information contained in this notice is true, accurate, and complete to the best of their knowledge."))
        sections.append(.init(text: ""))
        sections.append(.init(text: ""))
        sections.append(.init(text: "_________________________________"))
        sections.append(.init(text: "Authorized Signature"))
        sections.append(.init(text: ""))
        sections.append(.init(text: "Printed Name: \(data["authorizedName"] ?? "")"))
        sections.append(.init(text: "Title: \(data["authorizedTitle"] ?? "")"))
        sections.append(.init(text: "Organization: \(data["organizationName"] ?? "Helion Prime Financial Trust")"))

        return sections
    }
}
