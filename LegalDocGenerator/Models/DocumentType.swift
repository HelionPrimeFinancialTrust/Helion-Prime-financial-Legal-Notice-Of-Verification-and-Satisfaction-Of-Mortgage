//
//  DocumentType.swift
//  LegalDocGenerator
//
//  Defines all supported legal document types
//

import Foundation

enum DocumentType: String, CaseIterable, Identifiable {
    case mortgageSatisfaction = "Mortgage Satisfaction Notice"
    case powerOfAttorney = "Power of Attorney"
    case nda = "Non-Disclosure Agreement"
    case employmentContract = "Employment Contract"
    case lease = "Residential Lease Agreement"
    case promissoryNote = "Promissory Note"
    case billOfSale = "Bill of Sale"
    case lastWillTestament = "Last Will and Testament"
    case businessContract = "Business Contract"
    case serviceAgreement = "Service Agreement"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .mortgageSatisfaction: return "house.fill"
        case .powerOfAttorney: return "person.badge.key.fill"
        case .nda: return "lock.doc.fill"
        case .employmentContract: return "briefcase.fill"
        case .lease: return "key.fill"
        case .promissoryNote: return "dollarsign.circle.fill"
        case .billOfSale: return "cart.fill"
        case .lastWillTestament: return "doc.text.fill"
        case .businessContract: return "building.2.fill"
        case .serviceAgreement: return "hand.raised.fill"
        }
    }

    var description: String {
        switch self {
        case .mortgageSatisfaction:
            return "Legal notice confirming mortgage loan has been paid in full"
        case .powerOfAttorney:
            return "Grant authority to another person to act on your behalf"
        case .nda:
            return "Protect confidential information shared between parties"
        case .employmentContract:
            return "Define terms of employment between employer and employee"
        case .lease:
            return "Rental agreement for residential property"
        case .promissoryNote:
            return "Written promise to pay a specified amount of money"
        case .billOfSale:
            return "Transfer ownership of personal property"
        case .lastWillTestament:
            return "Specify distribution of assets after death"
        case .businessContract:
            return "Agreement between businesses or individuals"
        case .serviceAgreement:
            return "Contract for professional services"
        }
    }

    var requiredFields: [String] {
        switch self {
        case .mortgageSatisfaction:
            return ["borrowerName", "lenderName", "propertyAddress", "loanAmount", "satisfactionDate"]
        case .powerOfAttorney:
            return ["principalName", "agentName", "effectiveDate", "powers", "expirationDate"]
        case .nda:
            return ["disclosingParty", "receivingParty", "effectiveDate", "term", "governingLaw"]
        case .employmentContract:
            return ["employerName", "employeeName", "position", "salary", "startDate"]
        case .lease:
            return ["landlordName", "tenantName", "propertyAddress", "rentAmount", "leaseStart", "leaseTerm"]
        case .promissoryNote:
            return ["borrowerName", "lenderName", "principalAmount", "interestRate", "maturityDate"]
        case .billOfSale:
            return ["sellerName", "buyerName", "itemDescription", "purchasePrice", "saleDate"]
        case .lastWillTestament:
            return ["testatorName", "executorName", "beneficiaries", "assets", "dateCreated"]
        case .businessContract:
            return ["party1Name", "party2Name", "services", "compensation", "term"]
        case .serviceAgreement:
            return ["providerName", "clientName", "serviceDescription", "fees", "term"]
        }
    }
}
