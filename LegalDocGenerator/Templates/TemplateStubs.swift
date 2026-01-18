//
//  TemplateStubs.swift
//  LegalDocGenerator
//
//  Placeholder templates for additional document types
//

import Foundation

// MARK: - Power of Attorney

struct PowerOfAttorneyTemplate: DocumentTemplate {
    func generateContent(data: [String: String], documentId: String) -> [WordDocumentGenerator.ContentSection] {
        var sections: [WordDocumentGenerator.ContentSection] = []
        sections.append(.init(text: "POWER OF ATTORNEY", isHeading: false, style: .centered))
        sections.append(.init(text: ""))
        sections.append(.init(text: "I, \(data["principalName"] ?? "[PRINCIPAL]"), hereby appoint \(data["agentName"] ?? "[AGENT]") as my attorney-in-fact to act on my behalf."))
        sections.append(.init(text: "Effective Date: \(data["effectiveDate"] ?? "[DATE]")"))
        sections.append(.init(text: "Powers Granted: \(data["powers"] ?? "[POWERS]")"))
        sections.append(.init(text: "This Power of Attorney shall expire on: \(data["expirationDate"] ?? "[DATE]")"))
        return sections
    }
}

// MARK: - Employment Contract

struct EmploymentContractTemplate: DocumentTemplate {
    func generateContent(data: [String: String], documentId: String) -> [WordDocumentGenerator.ContentSection] {
        var sections: [WordDocumentGenerator.ContentSection] = []
        sections.append(.init(text: "EMPLOYMENT AGREEMENT", isHeading: false, style: .centered))
        sections.append(.init(text: ""))
        sections.append(.init(text: "This Employment Agreement is made between:"))
        sections.append(.init(text: "Employer: \(data["employerName"] ?? "[EMPLOYER]")"))
        sections.append(.init(text: "Employee: \(data["employeeName"] ?? "[EMPLOYEE]")"))
        sections.append(.init(text: "Position: \(data["position"] ?? "[POSITION]")"))
        sections.append(.init(text: "Salary: \(data["salary"] ?? "[SALARY]")"))
        sections.append(.init(text: "Start Date: \(data["startDate"] ?? "[DATE]")"))
        return sections
    }
}

// MARK: - Lease Agreement

struct LeaseAgreementTemplate: DocumentTemplate {
    func generateContent(data: [String: String], documentId: String) -> [WordDocumentGenerator.ContentSection] {
        var sections: [WordDocumentGenerator.ContentSection] = []
        sections.append(.init(text: "RESIDENTIAL LEASE AGREEMENT", isHeading: false, style: .centered))
        sections.append(.init(text: ""))
        sections.append(.init(text: "Landlord: \(data["landlordName"] ?? "[LANDLORD]")"))
        sections.append(.init(text: "Tenant: \(data["tenantName"] ?? "[TENANT]")"))
        sections.append(.init(text: "Property: \(data["propertyAddress"] ?? "[ADDRESS]")"))
        sections.append(.init(text: "Rent: \(data["rentAmount"] ?? "[AMOUNT]") per month"))
        sections.append(.init(text: "Lease Start: \(data["leaseStart"] ?? "[DATE]")"))
        sections.append(.init(text: "Lease Term: \(data["leaseTerm"] ?? "[TERM]")"))
        return sections
    }
}

// MARK: - Promissory Note

struct PromissoryNoteTemplate: DocumentTemplate {
    func generateContent(data: [String: String], documentId: String) -> [WordDocumentGenerator.ContentSection] {
        var sections: [WordDocumentGenerator.ContentSection] = []
        sections.append(.init(text: "PROMISSORY NOTE", isHeading: false, style: .centered))
        sections.append(.init(text: ""))
        sections.append(.init(text: "FOR VALUE RECEIVED, \(data["borrowerName"] ?? "[BORROWER]") promises to pay to \(data["lenderName"] ?? "[LENDER]") the principal sum of \(data["principalAmount"] ?? "[AMOUNT]")."))
        sections.append(.init(text: "Interest Rate: \(data["interestRate"] ?? "[RATE]")% per annum"))
        sections.append(.init(text: "Maturity Date: \(data["maturityDate"] ?? "[DATE]")"))
        return sections
    }
}

// MARK: - Bill of Sale

struct BillOfSaleTemplate: DocumentTemplate {
    func generateContent(data: [String: String], documentId: String) -> [WordDocumentGenerator.ContentSection] {
        var sections: [WordDocumentGenerator.ContentSection] = []
        sections.append(.init(text: "BILL OF SALE", isHeading: false, style: .centered))
        sections.append(.init(text: ""))
        sections.append(.init(text: "Seller: \(data["sellerName"] ?? "[SELLER]")"))
        sections.append(.init(text: "Buyer: \(data["buyerName"] ?? "[BUYER]")"))
        sections.append(.init(text: "Item Description: \(data["itemDescription"] ?? "[DESCRIPTION]")"))
        sections.append(.init(text: "Purchase Price: \(data["purchasePrice"] ?? "[AMOUNT]")"))
        sections.append(.init(text: "Sale Date: \(data["saleDate"] ?? "[DATE]")"))
        return sections
    }
}

// MARK: - Last Will and Testament

struct LastWillTestamentTemplate: DocumentTemplate {
    func generateContent(data: [String: String], documentId: String) -> [WordDocumentGenerator.ContentSection] {
        var sections: [WordDocumentGenerator.ContentSection] = []
        sections.append(.init(text: "LAST WILL AND TESTAMENT", isHeading: false, style: .centered))
        sections.append(.init(text: ""))
        sections.append(.init(text: "I, \(data["testatorName"] ?? "[TESTATOR]"), being of sound mind and memory, do hereby declare this to be my Last Will and Testament."))
        sections.append(.init(text: "Executor: \(data["executorName"] ?? "[EXECUTOR]")"))
        sections.append(.init(text: "Beneficiaries: \(data["beneficiaries"] ?? "[BENEFICIARIES]")"))
        sections.append(.init(text: "Date Created: \(data["dateCreated"] ?? "[DATE]")"))
        return sections
    }
}

// MARK: - Business Contract

struct BusinessContractTemplate: DocumentTemplate {
    func generateContent(data: [String: String], documentId: String) -> [WordDocumentGenerator.ContentSection] {
        var sections: [WordDocumentGenerator.ContentSection] = []
        sections.append(.init(text: "BUSINESS CONTRACT", isHeading: false, style: .centered))
        sections.append(.init(text: ""))
        sections.append(.init(text: "Party 1: \(data["party1Name"] ?? "[PARTY 1]")"))
        sections.append(.init(text: "Party 2: \(data["party2Name"] ?? "[PARTY 2]")"))
        sections.append(.init(text: "Services: \(data["services"] ?? "[SERVICES]")"))
        sections.append(.init(text: "Compensation: \(data["compensation"] ?? "[AMOUNT]")"))
        sections.append(.init(text: "Term: \(data["term"] ?? "[TERM]")"))
        return sections
    }
}

// MARK: - Service Agreement

struct ServiceAgreementTemplate: DocumentTemplate {
    func generateContent(data: [String: String], documentId: String) -> [WordDocumentGenerator.ContentSection] {
        var sections: [WordDocumentGenerator.ContentSection] = []
        sections.append(.init(text: "SERVICE AGREEMENT", isHeading: false, style: .centered))
        sections.append(.init(text: ""))
        sections.append(.init(text: "Service Provider: \(data["providerName"] ?? "[PROVIDER]")"))
        sections.append(.init(text: "Client: \(data["clientName"] ?? "[CLIENT]")"))
        sections.append(.init(text: "Service Description: \(data["serviceDescription"] ?? "[DESCRIPTION]")"))
        sections.append(.init(text: "Fees: \(data["fees"] ?? "[FEES]")"))
        sections.append(.init(text: "Term: \(data["term"] ?? "[TERM]")"))
        return sections
    }
}
