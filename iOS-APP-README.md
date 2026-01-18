# Legal Document Generator - iOS App

A comprehensive iOS application for generating professional legal documents with Microsoft Word, PDF, and text export capabilities.

## Overview

The Legal Document Generator is a native iOS app built with SwiftUI that enables users to create, edit, and export various types of legal documents directly from their iPhone or iPad. The app supports 10 different document types and can export to Word (.docx), PDF, and plain text formats.

## Features

### 📱 Native iOS Experience
- Built with SwiftUI for modern, responsive UI
- Support for iPhone and iPad
- Dark mode compatible
- Optimized for all screen sizes

### 📄 10 Document Types

1. **Mortgage Satisfaction Notice** - Legal notice confirming mortgage loan paid in full
2. **Power of Attorney** - Grant authority to another person
3. **Non-Disclosure Agreement (NDA)** - Protect confidential information
4. **Employment Contract** - Define employment terms
5. **Residential Lease Agreement** - Rental agreement for property
6. **Promissory Note** - Written promise to pay money
7. **Bill of Sale** - Transfer ownership of personal property
8. **Last Will and Testament** - Specify asset distribution
9. **Business Contract** - Agreement between businesses
10. **Service Agreement** - Contract for professional services

### 🎯 Key Capabilities

- **Template System** - Professional templates for each document type
- **Smart Validation** - Ensures all required fields are completed
- **Auto-Generated IDs** - Unique document identifiers
- **Multiple Export Formats**:
  - Microsoft Word (.docx)
  - PDF
  - Plain Text (.txt)
- **Document Management** - Save, edit, and organize documents
- **Share Integration** - Export and share via iOS share sheet
- **Local Storage** - Documents saved securely on device

## Architecture

### Project Structure

```
LegalDocGenerator/
├── LegalDocGeneratorApp.swift          # Main app entry point
├── Models/
│   ├── DocumentType.swift              # Document type definitions
│   └── LegalDocument.swift             # Document data model
├── Services/
│   ├── DocumentManager.swift           # Document management
│   ├── WordDocumentGenerator.swift     # Word export
│   ├── PDFDocumentGenerator.swift      # PDF export
│   └── TextDocumentGenerator.swift     # Text export
├── Templates/
│   ├── MortgageSatisfactionTemplate.swift
│   ├── NDATemplate.swift
│   └── TemplateStubs.swift             # Other templates
├── Views/
│   ├── ContentView.swift               # Main document list
│   ├── DocumentSelectorView.swift      # Document type picker
│   └── DocumentEditorView.swift        # Document editor
├── Resources/
└── Info.plist
```

### Technology Stack

- **Framework**: SwiftUI
- **Language**: Swift 5.9+
- **Minimum iOS**: iOS 16.0+
- **Document Generation**:
  - Word: XML-based .docx generation
  - PDF: UIKit PDFRenderer
  - Text: Plain text formatting

## Installation

### Requirements

- Xcode 15.0 or later
- iOS 16.0+ deployment target
- Swift 5.9+

### Setup Steps

1. **Open in Xcode**
```bash
cd LegalDocGenerator
open LegalDocGenerator.xcodeproj
```

2. **Configure Signing**
   - Select the project in Xcode
   - Go to Signing & Capabilities
   - Select your development team
   - Xcode will automatically manage provisioning

3. **Build and Run**
   - Select your target device or simulator
   - Press Cmd+R or click the Play button

## Usage

### Creating a Document

1. **Launch the app**
2. **Tap the + button** in the top right
3. **Select document type** from the grid
4. **Fill in required fields**
5. **Export** when ready

### Filling Out Documents

- All required fields are clearly marked
- App validates completion before allowing export
- Real-time status updates (Draft → Completed → Exported)

### Exporting Documents

The app offers three export formats:

#### Microsoft Word (.docx)
- Professional formatting
- Editable after export
- Compatible with all Word versions

#### PDF
- Print-ready format
- Preserves exact formatting
- Universal compatibility

#### Plain Text (.txt)
- Simple text format
- Maximum compatibility
- Easy to email or message

### Sharing Documents

After export:
1. Document automatically opens in share sheet
2. Choose sharing method:
   - Email
   - Messages
   - Files app
   - Cloud storage (iCloud, Dropbox, etc.)
   - Print
   - More options...

## Document Details

### Mortgage Satisfaction Notice

**Required Fields:**
- Borrower Name
- Lender Name
- Property Address
- Loan Amount
- Satisfaction Date

**Additional Fields:**
- Mortgage Date
- Mortgage Reference Number
- Recording Office
- City, State, ZIP
- Legal Description

### Non-Disclosure Agreement (NDA)

**Required Fields:**
- Disclosing Party
- Receiving Party
- Effective Date
- Term
- Governing Law

**Additional Fields:**
- Purpose
- Additional Terms

### Power of Attorney

**Required Fields:**
- Principal Name
- Agent Name
- Effective Date
- Powers
- Expiration Date

### Employment Contract

**Required Fields:**
- Employer Name
- Employee Name
- Position
- Salary
- Start Date

### Lease Agreement

**Required Fields:**
- Landlord Name
- Tenant Name
- Property Address
- Rent Amount
- Lease Start Date
- Lease Term

### Promissory Note

**Required Fields:**
- Borrower Name
- Lender Name
- Principal Amount
- Interest Rate
- Maturity Date

### Bill of Sale

**Required Fields:**
- Seller Name
- Buyer Name
- Item Description
- Purchase Price
- Sale Date

### Last Will and Testament

**Required Fields:**
- Testator Name
- Executor Name
- Beneficiaries
- Assets
- Date Created

### Business Contract

**Required Fields:**
- Party 1 Name
- Party 2 Name
- Services
- Compensation
- Term

### Service Agreement

**Required Fields:**
- Provider Name
- Client Name
- Service Description
- Fees
- Term

## Customization

### Adding New Document Types

1. **Add to DocumentType enum**
```swift
case newDocType = "New Document Type"
```

2. **Define required fields**
```swift
case .newDocType:
    return ["field1", "field2", "field3"]
```

3. **Create template**
```swift
struct NewDocTypeTemplate: DocumentTemplate {
    func generateContent(data: [String: String], documentId: String) -> [ContentSection] {
        // Template logic here
    }
}
```

4. **Update generators** to include new template

### Modifying Templates

Edit template files in `Templates/` directory:
- Modify text content
- Adjust formatting
- Add/remove sections
- Change field mappings

### Styling

- Fonts: Configured in generator classes
- Colors: SwiftUI system colors (adaptable to dark mode)
- Layout: SwiftUI responsive layouts

## Technical Details

### Word Document Generation

The app generates Word documents using XML-based format:

```swift
// Creates proper .docx XML structure
private func createWordXML(content: String, document: LegalDocument) -> String {
    return """
    <?xml version="1.0" encoding="UTF-8"?>
    <w:document xmlns:w="...">
        <w:body>
            \(content)
        </w:body>
    </w:document>
    """
}
```

**Note**: For production, consider using a full .docx library for complete compatibility.

### PDF Generation

Uses UIKit's PDFRenderer for high-quality PDF output:

```swift
let format = UIGraphicsPDFRendererFormat()
let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
let pdfData = renderer.pdfData { context in
    // Draw content
}
```

### Data Persistence

Documents are saved using UserDefaults with JSON encoding:

```swift
private func saveDocuments() {
    if let encoded = try? JSONEncoder().encode(documents) {
        UserDefaults.standard.set(encoded, forKey: documentsKey)
    }
}
```

**For production**: Consider using Core Data or CloudKit for:
- Better performance with many documents
- iCloud sync
- Advanced querying

## Security & Legal

### Data Privacy
- All documents stored locally on device
- No cloud storage or transmission
- No analytics or tracking
- User data never leaves the device

### Legal Disclaimer

⚠️ **IMPORTANT**: This app generates template-based legal documents. These templates are provided for informational purposes only and do not constitute legal advice.

**Users should:**
- Review all generated documents carefully
- Consult with a qualified attorney before using documents
- Understand applicable laws in their jurisdiction
- Verify all information is accurate and complete

**The app creators are not responsible for:**
- Legal validity of generated documents
- Compliance with local laws
- Accuracy of user-entered information
- Any legal consequences of document use

## Troubleshooting

### Documents Not Saving
- Check device storage
- Restart app
- Reinstall if necessary

### Export Not Working
- Ensure all required fields completed
- Check file permissions
- Try different export format

### Sharing Issues
- Grant app necessary permissions
- Check iOS share sheet access
- Try alternative sharing method

## Future Enhancements

### Planned Features
- [ ] iCloud sync
- [ ] Document templates library
- [ ] Custom branding/logos
- [ ] Multi-language support
- [ ] Electronic signatures
- [ ] Document versioning
- [ ] Batch document creation
- [ ] QR code verification
- [ ] Blockchain timestamping
- [ ] Custom field types
- [ ] Rich text editing
- [ ] Image attachments
- [ ] Collaborative editing

### Performance Optimizations
- [ ] Core Data migration
- [ ] Background document generation
- [ ] Improved PDF rendering
- [ ] Enhanced Word compatibility
- [ ] Caching system

## Support

### Getting Help
- **Email**: legal@helionprimefinancial.com
- **Phone**: (555) 123-4567
- **Website**: www.helionprimefinancial.com

### Reporting Issues
Please include:
- iOS version
- Device model
- Document type
- Steps to reproduce
- Screenshots if applicable

## License

Copyright © 2026 Helion Prime Financial Trust

MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software.

## Credits

**Developed by**: Helion Prime Financial Trust
**Version**: 1.0.0
**Platform**: iOS 16.0+
**Framework**: SwiftUI

---

## Quick Start Guide

### First Time Setup
1. Download from App Store
2. Open app
3. Grant necessary permissions
4. Create your first document

### Creating Your First Document
1. Tap **+** button
2. Select **Non-Disclosure Agreement**
3. Fill in:
   - Disclosing Party: "Your Company Inc."
   - Receiving Party: "Partner Company LLC"
   - Effective Date: Select today
   - Term: "2 years"
   - Governing Law: "California"
4. Tap **Export as Word Document**
5. Share via email or save to Files

### Tips for Best Results
- Complete all required fields before exporting
- Use consistent formatting for names and dates
- Preview documents before sharing
- Keep backups of important documents
- Review legal requirements for your jurisdiction

## FAQ

**Q: Are these documents legally binding?**
A: The documents follow standard legal formats, but you should consult an attorney for legal advice.

**Q: Can I edit documents after export?**
A: Yes, Word and text formats are fully editable. PDF is read-only.

**Q: Does the app work offline?**
A: Yes, all features work completely offline.

**Q: Is my data secure?**
A: Yes, all documents are stored locally on your device only.

**Q: Can I customize templates?**
A: The source code is open and can be modified. The app itself has fixed templates.

**Q: What iOS versions are supported?**
A: iOS 16.0 and later.

**Q: Does it work on iPad?**
A: Yes, fully optimized for iPad.

**Q: Can I print documents?**
A: Yes, export to PDF and use the iOS print function.

---

**Thank you for using Legal Document Generator!**

For updates, visit: www.helionprimefinancial.com
